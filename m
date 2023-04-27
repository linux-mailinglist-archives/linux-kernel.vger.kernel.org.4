Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896F06F08A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbjD0Prp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbjD0Prl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:47:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999D30D5;
        Thu, 27 Apr 2023 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682610459; x=1714146459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PUF8aPS0OKx4v6gIhz2D7a+SsHKjz/g9NG0aq4jVUtw=;
  b=kmG2SjEuG8aIDu8z7cosbC2/dkMouUzvwObAVteDeq0mX9/ldfUDQUwI
   1Rz/44SKqww9AmdAgIW/yILgC12pceLvWSV/bCBidt9h2hoHGT5+J7r6S
   ylEsMcUL/rXaWmZUzBCmOsv8+U6i28FZxHMWMyEE2IzAkHieM6pFvPtNx
   Etd/IhaD4aS6l2KCF5vYmtrP7kPjIPgdXG6fr/V5QWD1F3qnUPEZ49b77
   8VhYdUtuEA3qYKJYuaMQalGUM84tkBKGeQkl2wLaRg9kKH+5SuaX8gBjj
   mcfPjyg1RdOeP17cYM6vVfWfhgxPeHEBhe/hba2a9JrfV0uBDfw8CveV9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="327090070"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="327090070"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="671824584"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="671824584"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2023 08:47:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 08:47:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 08:47:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 08:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9XSmbjJYUE6YttOcntW6nterFKBMqQ1JyA7g7Zm8zjW/JiBbBoz5HO3IR1mPTiDwCPy9T0r2aUUvw7yy/LT5cYhd5hzNXipsp2nJxa3+XfPNNPqDAwCOU5u3Y+xwV3bofQg2b+A/Ywk8yFyn6SQ7q1NGaaUrCki0st2OgvFHBsXxgVffLc2KwXD2FBxqVal2IsgK8c1f7I8QnNVgWCmkJdBrjrAGtzyG1PsBvhJ9vlREW17hvyIRr89T8gQqb6DVuw2hkLq2X7ClWXu3a2C6Q/sRFXLM1s0gvuf8V/a6NvY128qoQ3xNH/N6LFPqaH+13eWgjY3BbSdDsWznf7chQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUF8aPS0OKx4v6gIhz2D7a+SsHKjz/g9NG0aq4jVUtw=;
 b=nXpTzDtbpwK++P6Ht30Ke4ikThO2iSfWTndx+9LfbHRuT0eBmA/PYDw6gGTCQSLIZSwxqLECgpMxr8Y/56MnZhUUUJ/DyuWI6WO7DNsaEGuqxx8RB2cp/jqI1QWrwVlS/veUpWKCQ3QdutY5uWsoPst+gqoJoojITA57VKcTQKBjBriC7c3xCtnwVoVGYR28qmC5a2xJyhl5rSgm6STYt38ul+Tv5FBLEuOvyUWjF6rq26rlTyu9WolU5udRMTtoBD5EjCpl7yMGBUK39WoekZmZoIRowEDJq/Xm96fHUX9h9qnfl958+pJH1i6f06AdND+Fw1bveCbGfNuzECDE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Thu, 27 Apr 2023 15:47:33 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e%2]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 15:47:33 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "Christopherson,, Sean" <seanjc@google.com>
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
Thread-Index: AQHZYLcIL5h5EiW/WUeIdC3dxCgzQa88TIUAgAFu+xCAACeogIAAEHyAgAFTKpCAAA0uAIAAJMug
Date:   Thu, 27 Apr 2023 15:47:33 +0000
Message-ID: <DM8PR11MB57502E1C09CDE4842B7F9B30E76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
         <ZEfrjtgGgm1lpadq@google.com>
         <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
         <7502e1af0615c08167076ff452fc69ebf316c730.camel@linux.ibm.com>
         <ZElOfzn37kmesy7e@google.com>
         <DM8PR11MB57509EBCB1E2146C1768A6EEE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <efda0be02fb0b5bf23aec11b5398d20908a821ba.camel@linux.ibm.com>
In-Reply-To: <efda0be02fb0b5bf23aec11b5398d20908a821ba.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BL1PR11MB5287:EE_
x-ms-office365-filtering-correlation-id: dc9cc2f6-efce-4002-23f1-08db4736b75b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIYhrVQEpYgY2yos0eAFCmQOQLhwfAXXvPx3xhB23oiYaZmDMSN2nfvuIirVIWlz8lfcViF5caTgLg+5UESnTvUDgEyCSm1n8XrBUyheLuJyXCLGmjO66Aw8m+tvRGu/Srxgt5cdgFQZEGhCmL2799pzX4l32GgkVjMqpWKx0JIdOxzCSlqxZyApWb/Eq+EHBqZmGI7V9hdBj9OarPD/dPJNxiuNU2K1EwC+8iqLnc/ppwbvldgaC9kly7lho2ssc+p90njNYQEKm1GbECzX21wk/8YpavvKxGqF+5XV0fvPccBrELdI5qn5XBd9GqVlbIOd0tClxPxz9DhgFBUPSRWN4JAiRWWW2UY8/rkCb/Dl5/jjTr9o521aqGv1HWZxMjq0r8i20wKiAa1eVzApmbQMJhIopD44x0B27ZTu4dxWSNcYUmZOXr1x42S0Fq0vNqFMGAgVklYmwyaR6TcjFlHCO/upNs2C8DfclUaQmhEdGiuN5UgxTNrRhTi0vrBBPjYT7MSqpMohXFAVacsE521ukxqC0HFOqrQDvyAQRBBLHRm4FrsCNh2PB4/jbjZDBmHZi3jFfACgIUMioOSbtULsHqBaXpS/qfg3oXendWmOvS46NtDet1XTGWTYvj6Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(478600001)(86362001)(6506007)(9686003)(26005)(7696005)(55016003)(71200400001)(186003)(33656002)(2906002)(15650500001)(38070700005)(4326008)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(316002)(38100700002)(41300700001)(122000001)(82960400001)(7416002)(7406005)(83380400001)(5660300002)(8676002)(52536014)(8936002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXdZYTF1RHZVMk8xeEZlMUZTWTdsdEdhci8rQy9tSUUxTTVPRExIVWdrUTAz?=
 =?utf-8?B?cmVDclNVZWFBK0Y4SFcxNXBHMHVwcGJIWVF2V0RqRjV6WnZjQ1ZrMjFrVGRo?=
 =?utf-8?B?OFBEMFdURWh5UW95QzRnS0JwaWR1MkQrWm9mRzFiSlZLWnYvaDV1aDJBZWdB?=
 =?utf-8?B?cE9tQkRoUWlpS0JZSzFlc3FCanliTGx2VmpYYXZnMFJOYUNVVERNaGRYUW1y?=
 =?utf-8?B?NjM4UGhKRnpTV1kvZFRSSlRreWJOa0F1WXhqMEVYaktqQUlCdHc3d242b3lh?=
 =?utf-8?B?am9aN1BtZ0IrL0UxMW5STjBqd0F6Z1ViK2NzOVJwNjJHQTdXaDZlcGJRRmIx?=
 =?utf-8?B?M2FEazBlaWVMNzg1QzdsNzNTUllURVZJM1o0TDB1V0ViRGpSSW5FSThPT21C?=
 =?utf-8?B?Z2Y3aG1pdjUwSDNjdnpzM1ZqYTJUU0lsTzVrRk4vRGhYY1JzenhEUVVxeXJp?=
 =?utf-8?B?N29ESW44d2FmQnE3Wmh2SENhc0NobzJKdTNPWStJRmp4Ri90bkxEeE12RlJM?=
 =?utf-8?B?bk0yYVFCYms2KzZDQmhlYi9OZGl0K2dIYU5zYU9LWlRLL3p0M3g3bGtpeHZR?=
 =?utf-8?B?RmhBdlNLd1RYOXhmSC9hNUFhNU5FS0IvY0Rra2hpTDFJT1BnSmNVUEZMK1lx?=
 =?utf-8?B?MVNMTDdOTjFyd0oyQjVCNVQzVC9MT0U4ZWRabXNLVXZ5UERFZHpjRlJUNXpW?=
 =?utf-8?B?VzJlckhRbGttZ3EybEVHTW9LaDQ4MFMwYTlGM0VHb0tPZVZyT3pnRTZub0N4?=
 =?utf-8?B?bHc4R2JTYU9ZbDVRWStOM2Z2VFgvWTMvNkJLclNoSHZ2YWZINXI3TjdHZjdt?=
 =?utf-8?B?clVlRUk5bldkS1BYemZ1blYxaVpac1dmMkhvbk8xRjE3N05kMHJRb2VxQkYw?=
 =?utf-8?B?Vi9CQkptRUlsU1k0SlJJS0dQUTlsRENidGxodm1SZ0pzL3BOZWpjSG45Tmw4?=
 =?utf-8?B?bG85REFFbVFtZDZmZEVUUWk4alp4WnpnTjIxUGh4SXpKb2Jhd1ZNaHluTU9t?=
 =?utf-8?B?VXdxclZwUjVLaG9XQWp0bTZNSWJCRlRYbUhwSEszVERLSzNJbW9ZOC9tbWZu?=
 =?utf-8?B?NmNiZ2cxU1pHa0s1cmdldFE1NDVLSkZHQ1FnSHl5VDh4dUdQZGpDSmRpUzEr?=
 =?utf-8?B?QXJsdzVvaWRCc0ZCMGtweE9DZERheDJ0RStrNUxQZDM3UnZaVEx5c050anhs?=
 =?utf-8?B?bHRSM3JjNVd0MnRHdXZhYnV6YmNLZy91NVY5akFqYWp0c0hUQjE3UVFTU3pX?=
 =?utf-8?B?SDBQRFdFdW41SzJUWXc2Qy96SnZMWkxXQmt5NzdmVThxcjN5Z095MVZBYmV2?=
 =?utf-8?B?SUhXUFVnVmQ2VmIyVjFqQXY3bXNXQTFrTW1BVkZQTm03dlNleHJwUStwbUtH?=
 =?utf-8?B?SGJBM3NjVFFsQU13cjhTbFBpSGFXOXcwd2wxTjRTeW01dG44UEM0Y3k1QjYr?=
 =?utf-8?B?dk9aa0VNYVBWbkd1MURBRHp5a3pzTFc0Y2ZicXFpaVljS1BUSm40Y0ZZZzI3?=
 =?utf-8?B?MjdNVWFGanR0WXdkdnZSSE1vdEVjSGk5V2NJWmIrZDBNbGVCRm8rMjI2WTly?=
 =?utf-8?B?ek9MS1I3dE1lOHJJeWYvVHE1MU9mZDJadUFOWXlMZlJrQUs2S2VLSk1YZ3Bo?=
 =?utf-8?B?LzhKejc4QXd4NlFOcFRTT1FxdDFSblQvVExJakNaUXhpa0h2ZndqQktxN0Vh?=
 =?utf-8?B?eWhYdnJZamU2RXZ4ZXE2aTZCZTNHaWExNkxTMC9pejNSaG5DbkpvUTFWdkYx?=
 =?utf-8?B?SFdKWTcxWWk4ZlcweWVONHVKTnpjTWhTMFpmRnB3U3NId3J3MzQ4d3hqNTY4?=
 =?utf-8?B?MzRHYmZoRTgwekoxazVSVFMrNTdmZWVyQjZPZzRoVnBhRHRvZW9rS2tlV1RB?=
 =?utf-8?B?SWFSdjc0T0trOU9qOWpFT1dBa2dZbzluN0VoUE1OelIySFBHbHV1cDhOVVk3?=
 =?utf-8?B?NnoybmlrS1o4MHVkOEdLWUlTUTViSzBtUGVlUVFiUFZOT1Yxelo3SlFuYSt3?=
 =?utf-8?B?b2wzM0JCTzNzK3ljWU9nWFF0Z1NnMmNhMDA2NEtMZXZBVDdydEpVY01aSEs4?=
 =?utf-8?B?VjlraUVmbnJKWnI5VDBoQzdrRlJENlZRSk8rVnczTEh4WkNuaHgvTTF2YmUw?=
 =?utf-8?Q?/eX5JOlMoMci1hwZx2XV/PCxx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9cc2f6-efce-4002-23f1-08db4736b75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 15:47:33.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLWhg+8S9OnmtEgCKvIEBDAPoPCwUUnwNxmxRwNd6Erj6pk8y2v6SlOv+96+fjDIiSM4Xh2DMgW9kB9fL77WplQmWtkTslx1SZ8wASaZkIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gVGh1LCAyMDIzLTA0LTI3IGF0IDEyOjQzICswMDAwLCBSZXNoZXRvdmEsIEVsZW5h
IHdyb3RlOg0KPiA+DQo+ID4gPiBPbiBXZWQsIEFwciAyNiwgMjAyMywgSmFtZXMgQm90dG9tbGV5
IHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDIwMjMtMDQtMjYgYXQgMTM6MzIgKzAwMDAsIFJlc2hl
dG92YSwgRWxlbmEgd3JvdGU6DQo+IFsuLi5dDQo+ID4gPiA+ID4gdGhlIHByYWN0aWNhbCBkZXBs
b3ltZW50IGNhbiBkaWZmZXIgb2YgY291cnNlLiBXZSBjYW4gcmVwaHJhc2UNCj4gPiA+ID4gPiB0
aGF0IGl0ICJhbGxvd3MgdG8gZXhjbHVkZSBhbGwgdGhlIENTUCdzIGluZnJhc3RydWN0dXJlIGFu
ZCBTVw0KPiA+ID4gPiA+IG91dCBvZiB0ZW5hbnQncyBUQ0IuIg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGF0J3MgZ2V0dGluZyBldmVuIG1vcmUgaW5hY2N1cmF0ZS7CoCBUbyBydW7CoCBpbiBhIENsb3Vk
IHdpdGgNCj4gPiA+ID4gQ29DbyB5b3UgdXN1YWxseSBoYXZlIHRvIGluc2VydCBzb21lIHByb3Zp
ZGVkIGNvZGUsIGxpa2UgT1ZNRg0KPiA+ID4gPiBhbmQsIGZvciBBTUQsIHRoZSBTVlNNLsKgIFRo
ZXNlIGFyZSBvZnRlbiBjdXN0b21pemVkIGJ5IHRoZSBDU1AgdG8NCj4gPiA+ID4gc3VpdCB0aGUg
Y2xvdWQgaW5mcmFzdHJ1Y3R1cmUsIHNvIHlvdSdyZSBydW5uaW5nIHRoZWlyIGNvZGUuwqAgVGhl
DQo+ID4gPiA+IGdvYWwsIEkgdGhpbmssIGlzIHRvIG1ha2Ugc3VyZSB5b3Ugb25seSBydW4gY29k
ZSB5b3UgdHJ1c3QgKHNvbWUNCj4gPiA+ID4gb2Ygd2hpY2ggbWF5IGNvbWUgZnJvbSB0aGUgQ1NQ
KSBpbiB5b3VyIFRDQiwgd2hpY2ggaXMgdmVyeQ0KPiA+ID4gPiBkaWZmZXJlbnQgZnJvbSB0aGUg
c3RhdGVtZW50IGFib3ZlLg0KPiA+ID4NCj4gPiA+IFllcy7CoCBBbmQgdGFraW5nIHRoaW5ncyBh
IHN0ZXAgZnVydGhlciwgaWYgd2Ugd2VyZSB0byBhc2sgc2VjdXJpdHkNCj4gPiA+IGNvbmNpb3Vz
IHVzZXJzIHdoYXQgdGhleSB3b3VsZCBjaG9vc2UgdG8gaGF2ZSBpbiB0aGVpciBUQ0I6IChhKQ0K
PiA+ID4gY2xvc2VkLXNvdXJjZSBmaXJtd2FyZSB3cml0dGVuIGJ5IGEgaGFyZHdhcmUgdmVuZG9y
LCBvciAoYikgb3Blbi0NCj4gPiA+IHNvdXJjZSBzb2Z0d2FyZSB0aGF0IGlzIHByb3ZpZGVkIGJ5
IENTUHMsIEkgYW0gYmV0dGluZyB0aGUNCj4gPiA+IG92ZXJ3aGVsbWluZyBtYWpvcml0eSB3b3Vs
ZCBjaG9vc2UgKGIpLg0KPiA+DQo+ID4gQXMgSSBhbHJlYWR5IHJlcGxpZWQgaW4gbXkgZWFybGll
ciBtZXNzYWdlIGZyb20geWVzdGVyZGF5LCB5ZXMsIHRoaXMNCj4gPiBpcyB0aGUgY2hvaWNlIHRo
YXQgYW55b25lIGhhcyBhbmQgaXQgaXMgZnJlZSB0byBtYWtlIHRoaXMgY2hvaWNlLiBObw0KPiA+
IHF1ZXN0aW9ucyBhc2tlZC4gKEJ0dywgcGxlYXNlIG5vdGUgdGhhdCB0aGUgYWJvdmUgc3RhdGVt
ZW50IGlzIG5vdA0KPiA+IDEwMCUgYWNjdXJhdGUgc2luY2UgdGhlIHNvdXJjZSBjb2RlIGZvciBp
bnRlbCBURFggbW9kdWxlIGlzIGF0IGxlYXN0DQo+ID4gcHVibGljKS4gSG93ZXZlciwgaWYgYXMg
eW91IHNhaWQgdGhlIG1ham9yaXR5IGNob29zZSAoYiksIHdoeSBkbyB0aGV5DQo+ID4gbmVlZCB0
byBlbmFibGUgdGhlIENvbmZpZGVudGlhbCBjbG91ZCBjb21wdXRpbmcgdGVjaG5vbG9naWVzIGxp
a2UgVERYDQo+ID4gb3IgU0VWLVNOUD8gSWYgdGhleSBjaG9vc2UgKGIpLCB0aGVuIHRoZSB3aG9s
ZSB0aHJlYXQgbW9kZWwgZGVzY3JpYmVkDQo+ID4gaW4gdGhpcyBkb2N1bWVudCBkbyBub3Qgc2lt
cGx5IGFwcGx5IHRvIHRoZW0gYW5kIHRoZXkgY2FuIGZvcmdldA0KPiA+IGFib3V0IGFueXRoaW5n
IHRoYXQgd2UgdHJ5IHRvIGRlc2NyaWJlIGhlcmUuDQo+IA0KPiBJIHRoaW5rIHRoZSBwcm9ibGVt
IGlzIHRoYXQgdGhlIHRlbm9yIG9mIHRoZSBkb2N1bWVudCBpcyB0aGF0IHRoZSBDU1ANCj4gc2hv
dWxkIGJlIHNlZW4gYXMgdGhlIGVuZW15IG9mIHRoZSB0ZW5hbnQuIA0KDQpXZSBkaWRu4oCZdCBp
bnRlbmQgdGhpcyBpbnRlcnByZXRhdGlvbiBhbmQgaXQgY2FuIGJlIGNlcnRhaW5seSBiZSBmaXhl
ZCBpZiANCnBlb3BsZSBzZWUgaXQgdGhpcyB3YXkuIA0KDQpXaGVyZWFzIGFsbCBDU1AncyB3YW50
IHRvIGJlDQo+IHNlZW4gYXMgdGhlIHBhcnRuZXIgb2YgdGhlIHRlbmFudCAoYWRtaXR0ZWRseSBz
byB0aGV5IGNhbiB1cHNlbGwNCj4gc2VydmljZXMpLiBJbiBwYXJ0aWN1bGFyLCBldmVuIGlmIHlv
dSBhZG9wdCAoYikgdGhlcmUgYXJlIHNldmVyYWwNCj4gcmVhc29ucyB3aHkgeW91J2QgdXNlIGNv
bmZpZGVudGlhbCBjb21wdXRpbmc6DQo+IA0KPiAgICAxLiBQcm90ZWN0aW9uIGZyb20gb3RoZXIg
dGVuYW50cyB3aG8gYnJlYWsgY29udGFpbm1lbnQgaW4gdGhlIGNsb3VkLg0KPiAgICAgICBUaGVz
ZSB0ZW5hbnRzIGNvdWxkIGV4ZmlsdHJhdGUgZGF0YSBmcm9tIE5vbi1Db0NvIFZNcywgYnV0IGxp
a2VseQ0KPiAgICAgICB3b3VsZCBiZSBkZXRlY3RlZCBiZWZvcmUgdGhleSBoYWQgdGltZSB0byBs
YXVuY2ggYW4gYXR0YWNrIHVzaW5nDQo+ICAgICAgIHZ1bG5lcmFiaWxpdGllcyBpbiB0aGUgY3Vy
cmVudCBsaW51eCBkZXZpY2UgZHJpdmVycy4NCg0KTm90IHN1cmUgaG93IHRoaXMgImxpa2VseSB0
byBiZSBkZXRlY3RlZCIgaXMgZ29pbmcgdG8gaGFwcGVuIGluIHByYWN0aWNlLiANCklmIHlvdSBo
YXZlIGEga25vd24gdnVsbmVyYWJpbGl0eSBhZ2FpbnN0IGEgQ29DbyBWTSAobGV0IHNheSBpbiBh
IGRldmljZQ0KZHJpdmVyIGludGVyZmFjZSBpdCBleHBvc2VzKSwgaXMgaXQgc28gbXVjaCBtb3Jl
IGRpZmZpY3VsdCBmb3IgYW4gYXR0YWNrZXINCnRvIGJyZWFrIGludG8gQ29DbyBWTSB2cyBub24t
Q29DbyBWTSBiZWZvcmUgaXQgaXMgZGV0ZWN0ZWQ/IA0KDQo+ICAgIDIuIExlZ2FsIGRhdGEgc2Vj
dXJpdHkuIMKgVGhlcmUncyBhIGxvdCBvZiB2YWx1ZSBpbiBhIENTUCBiZWluZyBhYmxlDQo+ICAg
ICAgIHRvIG1ha2UgdGhlIGxlZ2FsIHN0YXRlbWVudCB0aGF0IGl0IGRvZXMgbm90IGhhdmUgYWNj
ZXNzIHRvIGENCj4gICAgICAgY3VzdG9tZXIgZGF0YSBiZWNhdXNlIG9mIENvQ28uDQoNCkxldCdz
IGxlYXZlIGxlZ2FsIG91dCBvZiB0ZWNobmljYWwgZGlzY3Vzc2lvbiwgbm90IG15IGFyZWEuIA0K
DQo+ICAgIDMuIEluc2lkZXIgdGhyZWF0cyAoYnJpYmUgYSBDU1AgYWRtaW4gZW1wbG95ZWUpLiDC
oFRoaXMgb25lIG1pZ2h0IGdldA0KPiAgICAgICBhcyBmYXIgYXMgdHJ5aW5nIHRvIGxhdW5jaCBh
biBhdHRhY2sgb24gYSBDb0NvIFZNLCBidXQgaGF2aW5nDQo+ICAgICAgIGNoZWNrcyBhdCB0aGUg
Q1NQIHRvIGRldGVjdCBhbmQgZGVmZWF0IHRoaXMgd291bGQgd29yayBpbnN0ZWFkIG9mDQo+ICAg
ICAgIGV2ZXJ5IGluc2lkZXIgdGhyZWF0IGhhdmluZyB0byBiZSBkZWZlYXRlZCBpbnNpZGUgdGhl
IFZNLg0KDQpPaywgdGhpcyBhbmdsZSBtaWdodCBiZSB2YWxpZCBmcm9tIENTUCBwb2ludCBvZiB2
aWV3LCBpLmUuIG5vdGljaW5nIHN1Y2gNCmluc2lkZXIgYXR0YWNrcyBtaWdodCBiZSBlYXNpZXIg
SSBndWVzcyB3aXRoIENvQ28gVk1zLiANCg0KPiANCj4gSW4gYWxsIG9mIHRob3NlIGNhc2VzICh3
aGljaCBhcmUgbm90IGV4aGF1c3RpdmUpIHlvdSBjYW4gcmVnYXJkIHRoZSBDU1ANCj4gYXMgYSBw
YXJ0bmVyIG9mIHRoZSB0ZW5hbnQgd2hlbiBpdCBjb21lcyB0byBwcmV2ZW50aW5nIGFuZCBkZXRl
Y3RpbmcNCj4gdGhyZWF0cyB0byB0aGUgQ29DbyBWTSwgc28gZXh0cmVtZSBkZXZpY2UgZHJpdmVy
IGhhcmRlbmluZyBiZWNvbWVzIGZhcg0KPiBsZXNzIHJlbGV2YW50IHRvIHRoZXNlIGZhaXJseSBj
b25zaWRlcmFibGUgdXNlIGNhc2VzLg0KDQpJIHRoaW5rIHRoZSBmaXJzdCBjYXNlIHN0aWxsIGhv
bGRzLCBhcyB3ZWxsIGFzIG9uZSBjYXNlIHRoYXQgeW91IGhhdmUgbm90IGxpc3RlZDoNCmEgcmVt
b3RlIGF0dGFja2VyIGF0dGFja2luZyBDU1Agc3RhY2sgdXNpbmcgc29tZSBkaXNjb3ZlcmVkIGFu
ZCBub3QgeWV0IA0KZml4ZWQgdnVsbmVyYWJpbGl0eSAoc3RhY2sgaXMgYmlnLCBidWdzIGhhcHBl
biksIGdldHRpbmcgY29udHJvbCBvZiBDU1Agc3RhY2sNCmFuZCB0aGVuIGdvaW5nIGFmdGVyIHRo
ZSBDb0NvIFZNcyB0byBzZWUgd2hhdCBpdCBjYW4gZ2V0IHRoZXJlLiANCldoYXQgeW91IGFyZSBz
YXlpbmcgaXMgdGhhdCB5b3UgKGFzIENTUCkgbWFpbnRhaW4gdGhlIGdvb2QgZmlyc3QgbGV2ZWwg
ZGVmZW5zZQ0KdG8gcHJldmVudCBhdHRhY2tlciB0byBnZXQgY29udHJvbCBvZiB5b3VyL0NTUCBz
dGFjayB0byBiZWdpbiB3aXRoLg0KV2hhdCB3ZSB0cnkgdG8gZG8gaXMgdGhlIG5leHQgbGV2ZWwg
b2YgZGVmZW5zZSAodmVyeSB0eXBpY2FsIGluIGFueSBzZWN1cml0eSk6DQp3ZSBhc3N1bWUgdGhh
dCBmaXJzdCBsaW5lIG9mIGRlZmVuc2UgaGFzIGJlZW4gYnJva2VuIGZvciBzb21lIHJlYXNvbiBh
bmQNCm5vdyB0aGVyZSBpcyBhIHNlY29uZCBvbmUgcGxhY2VkIHRvIGFjdHVhbGx5IHByb3RlY3Qg
Y3VzdG9tZXJzIGVuZCBkYXRhLiAgDQoNCj4gDQo+ID4gTm93IGZyb20gdGhlIHB1cmUgc2VjdXJp
dHkgcG9pbnQgb2YgdmlldyB0aGUgY2hvaWNlIGJldHdlZW4gKGEpIGFuZA0KPiA+IChiKSBpcyBu
b3Qgc28gZWFzaWx5IGRvbmUgaW1vLiBVc3VhbGx5IHdlIHRha2UgaW50byBhY2NvdW50IG1hbnkN
Cj4gPiBmYWN0b3JzIHRoYXQgYWZmZWN0IHRoZSByaXNrL2NoYW5jZXMgdGhhdCBjZXJ0YWluIHBp
ZWNlIG9mIFNXIGhhcyBhDQo+ID4gaGlnaGVyIHJpc2sgb2YgaGF2aW5nIHZ1bG5lcmFiaWxpdGll
cy4gVGhpcyBpbmNsdWRlcyB0aGUgc2l6ZSBvZiB0aGUNCj4gPiBjb2RlYmFzZSwgaXRzIGNvbXBs
ZXhpdHksIGl0cyBhdHRhY2sgc3VyZmFjZSBleHBvc3VyZSB0b3dhcmRzDQo+ID4gZXh0ZXJuYWwg
aW50ZXJmYWNlcywgbGV2ZWwgb2YgdGVzdGluZywgd2hlbmV2ZXIgdGhlIGNvZGUgaXMgcHVibGlj
LA0KPiA+IGNvZGUgZGVwZW5kZW5jeSBjaGFpbnMsIGV0Yy4gU21hbGxlciBjb2RlYmFzZSB3aXRo
IG5vIGRlcGVuZGVuY2llcw0KPiA+IGFuZCBzbWFsbCBzZXQgb2YgZXhwb3NlZCBpbnRlcmZhY2Vz
IGlzIHVzdWFsbHkgZWFzaWVyIHRvIHJldmlldyBmcm9tDQo+ID4gc2VjdXJpdHkgcG9pbnQgb2Yg
dmlldyBnaXZlbiB0aGF0IHRoZSBjb2RlIGlzIHB1YmxpYy4NCj4gDQo+IFRoaXMgcmVhZHMgbGlr
ZSBhbiBhcmd1bWVudCB0aGF0LCBmcm9tIGEgc2VjdXJpdHkgcG9pbnQgb2YgdmlldywNCj4gc21h
bGxlciBwcm9wcmlldGFyeSBjb2RlIGlzIGJldHRlciB0aGFuIGxhcmdlciwgb3BlbiBzb3VyY2Us
IGNvZGUuIEkNCj4gcmVhbGx5IGRvbid0IHRoaW5rIHdlIHdhbnQgdG8gb3BlbiB0aGlzIGNhbiBv
ZiB3b3Jtcy4gDQoNCkkgZG9u4oCZdCB0aGluayBJIGhhdmUgbWFkZSB0aGlzIHN0YXRlbWVudDog
dGhlIGNvZGUgKmhhcyB0byBiZSBwdWJsaWMqDQpmb3IgYW55b25lIHRvIHJldmlldyBhbmQgSSBk
aWQgZXhwbGljaXRseSBsaXN0IHRoaXMgaW4gdGhlIHN0YXRlbWVudCBhYm92ZSANCmFzICJnaXZl
biB0aGF0IHRoZSBjb2RlIGlzIHB1YmxpYyIuICBPbmx5IHRoaW5nIEkgbWVhbnQgaXMgdGhhdCBp
dCBpcyBub3QgDQpub3Qgc28gZWFzeSB0byBtYWtlIGEgY2FsbCBiZXR3ZWVuIChhKSBhbmQgKGIp
IGluIGFsbCBjYXNlcyBmcm9tIGEgcHVyZQ0Kc2VjdXJpdHkgcG9pbnQgb2Ygdmlldy4gDQoNCkJl
c3QgUmVnYXJkcywNCkVsZW5hLg0K
