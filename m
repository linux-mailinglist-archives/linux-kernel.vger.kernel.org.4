Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5756832D3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAaQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjAaQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:35:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4314207
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675182892; x=1706718892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ji2OeYmi3chwkPZ/bLXDPoa1F9S6Wm4SOu7y6okGwS0=;
  b=Wiy8ClIBkx3SUPmSMA+fm5z+emUOInvUXhhnuJb8/1k+4N4sL2+44Hto
   siFXqmWpN6DDutrNJlzS6ymmU2eKOHXnjRW++7zNAjocqZKbbWdbEOgMg
   r7XfxQKR1LX3dJOSRzKOCeqQ1T0liMKstxKuaafayV0goDwYC6nYslDrT
   gXGQH1Mm4OvXVugbftNLGkw35st8hpmdWEQ7at2S3Cf/t+rUJRbXSsMNz
   +65bxUg57fJmJEhQy5LCGzunKUP/gqea9E6dx9lqXiROYz4utKIQQgJwz
   pqcbe5/g6peAwh/o72fotcQEkGHVd5UEBqxDlg1E18zDYEyIOfHC3Ymxu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="414100914"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="414100914"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657946469"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657946469"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2023 08:34:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 08:34:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 08:34:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 08:34:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoE7fN/jWBxgux+d9HRWwnkpTIySthFC2mBzR0IGUueMLKzFNNjmA2y0laSj/EDQyaePvyS4/cETq12VgNwZZo2H+HqUP7Ak6cMcQyrQTZreFOL7K/VMjtHuz0cm+bRwEA2d2GPi8sbdObjR61WD7RQWA/jCn2yi+QTfl4voAIjk9RvCgA16oYWIfyG4QsXSuWwitaKl19nmU1zf+MMpWij6bby3YoLw2nEHoQmkpMz/YMvvTeisyky4RxuGqg1/9T4xkjurGKfLZkEfMvPw+x3zDRkbp9zlIrdCtCft68f+Yg4y89/qjnLc+tS/FzqHKXJVImPQ9i5XZ0zDfCsiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji2OeYmi3chwkPZ/bLXDPoa1F9S6Wm4SOu7y6okGwS0=;
 b=EUqWltNWGE84cnU/1+/0R+pVs7D7oXIn+dMk2cjXlDipIamEatzkXntrgQOnqNoR9wZCiPyLuDQqHoxvbXR0aW4EQd8FyHloT68/wKX0qmtjRvgCEOUE8oGZe7gmHR/j+aECOafh2wxpOlMTbG88omZDsVZJc7JBgHNUE/BH4OBdGPhpEXmuKVN9RNezJ3mHxZU4KayLkqQWmWHgPCsWUZkNhsPVGB3q2NQlSP8jYs+UR4dBKXZ5f3jOSxLxkoORRuw3tDYMw/tSPqYpW4mylgbOLXTtVZ+L1maH8SBsPB5ycMAErHJ4hqUAxDN4EeUFH6xeHtIAFPCuzwVr2z9ZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.33; Tue, 31 Jan 2023 16:34:20 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:34:19 +0000
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
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAKubQgAAALAEwAAJJbIAAAYhDQAA/PSiAAH3FjMAACv0HgAAuiKcwAAVpSwAAAQqboA==
Date:   Tue, 31 Jan 2023 16:34:19 +0000
Message-ID: <DM8PR11MB5750EC7B7FE96476BA0F652EE7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9EkCvAfNXnJ+ATo@kroah.com>
         <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9Jh2x9XJE1KEUg6@unreal>
         <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9JyW5bUqV7gWmU8@unreal>
         <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
         <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
         <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
         <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <261bc99edc43990eecb1aac4fe8005cedc495c20.camel@linux.ibm.com>
In-Reply-To: <261bc99edc43990eecb1aac4fe8005cedc495c20.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|MW4PR11MB7008:EE_
x-ms-office365-filtering-correlation-id: 09e49973-600f-48e2-5eb6-08db03a900ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBA/tohE2OTTl2i5baqq3xsSaJh8QiMER88r8ZCPcdeQnwnALSEWPxfsAnRTwhxpVtTZw/LtHtUxGWzjLLWMkBJSSKxUgpYaso4UK5ySQ0aiHNqtGfrFbGliyZPhN7tllBqiJGj4StwWjs9ivCzCaEWYu7zfgXAryk+Tz6fRZ3kAu75kKUyZwp69hINp+Jq3FPqmnVYXJIP4fOsvLdw0Uj9U1XavrHWCS7vP4oTMxmphOS3m9ZraXiykl7aC1THnLr+9+i7fS/VlPKXS0QALApBbPm+S9BPWtLAIBJrXNQZKfQeSwd/SzcgMTPAarPbZsvcOUxDKFE3K9hpc1tZtod3PbYLO6nvqZyJONKxU9M1qqez+GZjHIzivA4DwJ5z0NEkgGGjBky+mZCQFXYjiKuqsaRoW4tdmyfAEl2LqRt4yzVVNwh/kgp1Ck8+V7lIMYuvloxHJUXakBbneyBVKqm/P7ffibZfj8lJ9tre80WA981OY76sSF0sZ3kpW8ttz5M+82rN6QrBrhbgcOm4ieuREMESMtyS/IwjihHP6W0kJXSThC37/ztsLhrLWzLNgdw5MaSpzDaZn1oVg7gXZVa5eNnGy8KHgvTpbYfQfDYQHtHmvfB01HfCTUXxoe6A2wT86FX8GVHVyaTeL3C2NA/PpRsJpAdkQv3j1OxrQ/tZXyujW3/e6z0TEeEodTTIVUZR3oBoyEbaxrat/JAU6ypx4FKWQuHeeH8FtmLqOU8+Ph3fOJgl5mILjw5TOqIUktLBgM4x0VEJ5PEZvdYVw5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(71200400001)(86362001)(316002)(33656002)(8936002)(52536014)(7416002)(41300700001)(83380400001)(55016003)(66946007)(66556008)(76116006)(64756008)(5660300002)(4326008)(66446008)(122000001)(66476007)(8676002)(2906002)(110136005)(54906003)(478600001)(82960400001)(966005)(6506007)(38070700005)(26005)(38100700002)(7696005)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkxiV0JTbnBmdkZnSVNvRUxmb3d2T3FpTk5KM2JPZVd6NVBxNUhPZWYybWxX?=
 =?utf-8?B?b1lDMW9FNW1ZSkJpVUxyM2JHVk94UjBrdzUyTFlpbURPK3UrcXRaRnJScWVm?=
 =?utf-8?B?eWFTeTZTQWpsdGI0eUtLck5DUmhodU0rQmJTU3dVdHR6d2hJNE5sQTZSRmJt?=
 =?utf-8?B?RDNsaURORDVJVkRnYmNCWUliMldkSGc3SGdPcEpBUnY5V3YxdmlCUGFqSk96?=
 =?utf-8?B?OU10Q0tGcTdPQXpFODR0ci9hNTRFZFcwZXVCZGp5M0lqR3FCRHlTek1YZnN3?=
 =?utf-8?B?TElNV2dWaEdjenk3dUJQT2xVd0U5SjY2N0dzZytFYlJreUUwUitvT2crZmNp?=
 =?utf-8?B?bDdjZkpiQnlBRnRuVkJSaWhiSVk3Q2NISFY3a2ZHZzRGU2djSk0ySXFDK2V3?=
 =?utf-8?B?M1RMOGNKQ3owcGQyMXhLK3p4cU1JUVNJOEdzV0NUU0MySzlRczJXQ2FSdmpt?=
 =?utf-8?B?eFRUTm82akVXbU80dHB4a3I4YW5kNDRzS1gzK3dyM2czUlZsMWtMZzlxd09V?=
 =?utf-8?B?RTh3RFpZRXd4d3BPQVRiV0FSRER3bFZDNitGaVB6RUxXUCtxV0krYkUrL202?=
 =?utf-8?B?NDl0SG94L2JaaDQ5aGRaaU8zaFdsaFVzdmNZWHpTODZaemRPMTgvS3V4ejg5?=
 =?utf-8?B?OTM1TVkvaUFlS2N6NTZRQWp5RlJ1ZU1aY0NYZTIrUHUxa2RRN3V6SlZhNFUr?=
 =?utf-8?B?R1RuelVtWDJuRDZ6aWdMZGlRNzlCU3pRSkp5K3JEdkhBc3pNcWZhSk44cHZL?=
 =?utf-8?B?M0NoQWR4YWRoaEdjK3BDbUZJUVMzcDFGWWJNZXRyTkluQ245bG1lbm44MjhE?=
 =?utf-8?B?dGF0YjFBcjJkL3AzNFh4Sm1JTWpBKzVpVk8rbEVxUG9tR3ZVQXFEK29Kb3VE?=
 =?utf-8?B?YUNSQ2RXc0JUMmo1MUtHRm5NZThsUm9qMXZpLzg4Y0l4b2ZTMWxoYUphdTJj?=
 =?utf-8?B?d2l4U2JWakc0dGJIcVNBTXZNN2RaNklLQ0lJT0ltQzRuNFlkbWFFTVFQdTAy?=
 =?utf-8?B?Q3Bwdnl3ZkZCYUlBQU5ZcVNKOUJORXh4dWVWTGZqQlh1YzR6cFhwNDFVYzRC?=
 =?utf-8?B?MWpRb3RFVjQwYkZRWE9od1M2bWVzclV0QXNmcDVGVEVIUkp5aFNlV25ZNVBs?=
 =?utf-8?B?ZlRWZWtXcTN0T1NUVjdrOTJWRng5TkRRLy9WSGNkM3ZSa29kUlRoeXBBczkr?=
 =?utf-8?B?UE1vRGdMYzV1T3pUejd2TTU5VTRYdUllUjZCSHdhcGtGYTYvMDlKUjFxazh2?=
 =?utf-8?B?WlZ4TXFodk5hVFU4Q3RsdlBnRXdTM1R6ajZJMGxqWW5Cc1Q3N1NmYzRqQmdX?=
 =?utf-8?B?b2xvUlZrY2x5bHFVVWQvNnE3M0g1WlkwREEvSjN3c1Q2eWZOelBGMnN2ZkNv?=
 =?utf-8?B?bENKQzN4WXhMbjFtRlRJNUdXOGtIbElqUU9RSnI1U2RGTWZPdXRkTVFNWWcy?=
 =?utf-8?B?MjV4VFRSNE42bXFxbkMxSFdlTjI2alFJVXg1RUtxQWVnaGtmdEFBcEdEbExs?=
 =?utf-8?B?L2M0dWJjamNMRWFqK2xUaTNWRGpzU1RoN3hjYW9INFRzTnFBNEFaR0pRWnB3?=
 =?utf-8?B?LytXMVMxMm8rZ3h0VkZYRUJPeW5OM0k4Z2hUa2hSZ0pRakVIOFQyY3BKTUt0?=
 =?utf-8?B?ekdveGZRUXF4TFZDTFpzbEZqNFUwSXA5Y2hiaVNGTkZrb1NKZ3JyaEpqOUR0?=
 =?utf-8?B?TFNEMldRSjhQRTNBYjVaTytMdzRZZlc0VUpjZllaMElWRW4rTERwVWY0cUxX?=
 =?utf-8?B?b1UzcFp0aGtTQkJETjFBWFhjcU5sSkkwNy9WWFI4a3dEeFpsMmQ5RlZVUkt4?=
 =?utf-8?B?Y2RTRkMxM25qNmwwUE9UUjh3OElXOXpiRVp3VGRxaWNHa3VLNzloOFF1TXpI?=
 =?utf-8?B?MHFkaFkvSmx6ZVI4U29DNk80YWlncHIwZkJkZ1YrL3JOMFBmeUhJbGRERkEy?=
 =?utf-8?B?UTFsS09CUkhERVNYcyt2aWttWHNmeUdoMXRmckZZekEyV1dJakFoMmEwYXBX?=
 =?utf-8?B?SHpjeUZZczlkZ2QyNHpOanZRa0dmTTRqd1N0OE1DOVJSaENaT1VFc2hkTW5X?=
 =?utf-8?B?MlZETU9LOUI1MEQ3ZXYzNHJIQkIzK09IZ1NrTnhsbFhhZnVmdC9aMDhDM1BF?=
 =?utf-8?Q?NH4w+SZMIuKV36kPl/XJNobIC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e49973-600f-48e2-5eb6-08db03a900ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 16:34:19.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1T5CnFyR1vS8orZtAaIhu7JxjsvlTfAhDRnX9/T6nyrTm37PGmdY1GdbZaAEz6biGshjxkAnMV5gC009sbCoHii/iyV8WhSJQb1f9YbDLz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIDIwMjMtMDEtMzEgYXQgMTE6MzEgKzAwMDAsIFJlc2hldG92YSwgRWxlbmEgd3Jv
dGU6DQo+ID4gPiBPbiBNb24sIDIwMjMtMDEtMzAgYXQgMDc6NDIgKzAwMDAsIFJlc2hldG92YSwg
RWxlbmEgd3JvdGU6DQo+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+IFRoZSBiaWcgdGhyZWF0IGZyb20g
bW9zdCBkZXZpY2VzIChpbmNsdWRpbmcgdGhlIHRodW5kZXJib2x0DQo+ID4gPiA+ID4gY2xhc3Nl
cykgaXMgdGhhdCB0aGV5IGNhbiBETUEgYWxsIG92ZXIgbWVtb3J5LsKgIEhvd2V2ZXIsIHRoaXMN
Cj4gPiA+ID4gPiBpc24ndCByZWFsbHkgYSB0aHJlYXQgaW4gQ0MgKHdlbGwgdW50aWwgUENJIGJl
Y29tZXMgYWJsZSB0byBkbw0KPiA+ID4gPiA+IGVuY3J5cHRlZCBETUEpIGJlY2F1c2UgdGhlIGRl
dmljZSBoYXMgc3BlY2lmaWMgdW5lbmNyeXB0ZWQNCj4gPiA+ID4gPiBidWZmZXJzIHNldCBhc2lk
ZSBmb3IgdGhlIGV4cGVjdGVkIERNQS4gSWYgaXQgd3JpdGVzIG91dHNpZGUNCj4gPiA+ID4gPiB0
aGF0IENDIGludGVncml0eSB3aWxsIGRldGVjdCBpdCBhbmQgaWYgaXQgcmVhZHMgb3V0c2lkZSB0
aGF0DQo+ID4gPiA+ID4gaXQgZ2V0cyB1bmludGVsbGlnaWJsZSBjaXBoZXJ0ZXh0LsKgIFNvIHdl
J3JlIGxlZnQgd2l0aCB0aGUNCj4gPiA+ID4gPiBkZXZpY2UgdHJ5aW5nIHRvIHRyaWNrIHNlY3Jl
dHMgb3V0IG9mIHVzIGJ5IHJldHVybmluZw0KPiA+ID4gPiA+IHVuZXhwZWN0ZWQgZGF0YS4NCj4g
PiA+ID4NCj4gPiA+ID4gWWVzLCBieSBzdXBwbHlpbmcgdGhlIGlucHV0IHRoYXQgaGFzbuKAmXQg
YmVlbiBleHBlY3RlZC4gVGhpcyBpcw0KPiA+ID4gPiBleGFjdGx5IHRoZSBjYXNlIHdlIHdlcmUg
dHJ5aW5nIHRvIGZpeCBoZXJlIGZvciBleGFtcGxlOg0KPiA+ID4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyMzAxMTkxNzA2MzMuNDA5NDQtMi0NCj4gPiA+IGFsZXhhbmRlci5zaGlz
aGtpbkBsaW51eC5pbnRlbC5jb20vDQo+ID4gPiA+IEkgZG8gYWdyZWUgdGhhdCB0aGlzIGNhc2Ug
aXMgbGVzcyBzZXZlcmUgd2hlbiBvdGhlcnMgd2hlcmUgbWVtb3J5DQo+ID4gPiA+IGNvcnJ1cHRp
b24vYnVmZmVyIG92ZXJydW4gY2FuIGhhcHBlbiwgbGlrZSBoZXJlOg0KPiA+ID4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAxMTkxMzU3MjEuODMzNDUtNi0NCj4gPiA+IGFsZXhh
bmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20vDQo+ID4gPiA+IEJ1dCB3ZSBhcmUgdHJ5aW5n
IHRvIGZpeCBhbGwgaXNzdWVzIHdlIHNlZSBub3cgKHByaW9yaXRpemluZyB0aGUNCj4gPiA+ID4g
c2Vjb25kIG9uZXMgdGhvdWdoKS4NCj4gPiA+DQo+ID4gPiBJIGRvbid0IHNlZSBob3cgTVNJIHRh
YmxlIHNpemluZyBpcyBhIGJ1ZyBpbiB0aGUgY2F0ZWdvcnkgd2UndmUNCj4gPiA+IGRlZmluZWQu
wqAgVGhlIHZlcnkgdGV4dCBvZiB0aGUgY2hhbmdlbG9nIHNheXMgInJlc3VsdGluZyBpbiBhDQo+
ID4gPiBrZXJuZWwgcGFnZSBmYXVsdCBpbiBwY2lfd3JpdGVfbXNnX21zaXgoKS4iwqAgd2hpY2gg
aXMgYSBjcmFzaCwNCj4gPiA+IHdoaWNoIEkgdGhvdWdodCB3ZSB3ZXJlIGFncmVlaW5nIHdhcyBv
dXQgb2Ygc2NvcGUgZm9yIENDIGF0dGFja3M/DQo+ID4NCj4gPiBBcyBJIHNhaWQgdGhpcyBpcyBh
biBleGFtcGxlIG9mIGEgY3Jhc2ggYW5kIG9uIHRoZSBmaXJzdCBsb29rDQo+ID4gbWlnaHQgbm90
IGxlYWQgdG8gdGhlIGV4cGxvaXRhYmxlIGNvbmRpdGlvbiAoYWxiZWl0IGF0dGFja2VycyBhcmUN
Cj4gPiBjcmVhdGl2ZSkuIEJ1dCB3ZSBub3RpY2VkIHRoaXMgb25lIHdoaWxlIGZ1enppbmcgYW5k
IGl0IHdhcyBjb21tb24NCj4gPiBlbm91Z2ggdGhhdCBwcmV2ZW50ZWQgZnV6emVyIGdvaW5nIGRl
ZXBlciBpbnRvIHRoZSB2aXJ0aW8gZGV2aWNlcw0KPiA+IGRyaXZlciBmdXp6aW5nLiBUaGUgY29y
ZSBQQ0kvTVNJIGRvZXNu4oCZdCBzZWVtIHRvIGhhdmUgdGhhdCBtYW55DQo+ID4gZWFzaWx5IHRy
aWdnZXJhYmxlIE90aGVyIGV4YW1wbGVzIGluIHZpcnRpbyBwYXRjaHNldCBhcmUgbW9yZSBzZXZl
cmUuDQo+IA0KPiBZb3UgY2l0ZWQgdGhpcyBhcyB5b3VyIGV4YW1wbGUuICBJJ20gcG9pbnRpbmcg
b3V0IGl0IHNlZW1zIHRvIGJlIGFuDQo+IGV2ZW50IG9mIHRoZSBjbGFzcyB3ZSd2ZSBhZ3JlZWQg
bm90IHRvIGNvbnNpZGVyIGJlY2F1c2UgaXQncyBhbiBvb3BzDQo+IG5vdCBhbiBleHBsb2l0LiAg
SWYgdGhlcmUgYXJlIGV4YW1wbGVzIG9mIGZpeGluZyBhY3R1YWwgZXhwbG9pdHMgdG8gQ0MNCj4g
Vk1zLCB3aGF0IGFyZSB0aGV5Pw0KPiANCj4gVGhpcyBwYXRjaCBpcywgaG93ZXZlciwgYW4gZXhh
bXBsZSBvZiB0aGUgcHJvYmxlbSBldmVyeW9uZSBlbHNlIG9uIHRoZQ0KPiB0aHJlYWQgaXMgY29t
cGxhaW5pbmcgYWJvdXQ6IGEgcGF0Y2ggd2hpY2ggYWRkcyBhbiB1bm5lY2Vzc2FyeSBjaGVjayB0
bw0KPiB0aGUgTVNJIHN1YnN5c3RlbTsgdW5uZWNlc3NhcnkgYmVjYXVzZSBpdCBkb2Vzbid0IGZp
eCBhIENDIGV4cGxvaXQgYW5kDQo+IGluIHRoZSByZWFsIHdvcmxkIHRoZSB0YWJsZXMgYXJlIGNv
cnJlY3QgKG9yIHRoZSBtYW51ZmFjdHVyZXIgaXMNCj4gcXVpY2tseSBjaGFzdGVuZWQpLCBzbyBp
dCBhZGRzIG92ZXJoZWFkIHRvIG5vIGJlbmVmaXQuDQoNCkhvdyBjYW4geW91IG1ha2Ugc3VyZSB0
aGVyZSBpcyBubyBleHBsb2l0IHBvc3NpYmxlIHVzaW5nIHRoaXMgY3Jhc2gNCmFzIGEgc3RlcHBp
bmcgc3RvbmUgaW50byBhIENDIGd1ZXN0PyBPciBhcmUgeW91IHNheWluZyB0aGF0IHdlIGFyZSBi
YWNrIA0KdG8gdGhlIHRpbWVzIHdoZW4gd2UgY2FuIG1lcmdlIHRoZSBmaXhlcyBmb3IgY3Jhc2hl
cyBhbmQgb3V0IG9mIGJvdW5kIGVycm9ycyBpbg0Ka2VybmVsIG9ubHkgZ2l2ZW4gdGhhdCB3ZSBz
dWJtaXQgYSBwcm9vZiBvZiBjb25jZXB0IGV4cGxvaXQgd2l0aCB0aGUNCnBhdGNoIGZvciBldmVy
eSBpc3N1ZT8gDQoNCj4gDQo+IA0KPiBbLi4uXQ0KPiA+ID4gc2VlIHdoYXQgZWxzZSBpdCBjb3Vs
ZCBkZXRlY3QgZ2l2ZW4gdGhlIHNpZ25hbCB3aWxsIGJlIHNtb3RoZXJlZCBieQ0KPiA+ID4gb29w
c2VzIGFuZCBzZWNvbmRseSBJIHRoaW5rIHRoZSBQQ0kgaW50ZXJmYWNlIGlzIGxpa2VseSB0aGUg
d3JvbmcNCj4gPiA+IHBsYWNlIHRvIGJlZ2luIGFuZCB5b3Ugc2hvdWxkIHByb2JhYmx5IGJlZ2lu
IG9uIHRoZSB2aXJ0aW8gYnVzIGFuZA0KPiA+ID4gdGhlIGh5cGVydmlzb3IgZ2VuZXJhdGVkIGNv
bmZpZ3VyYXRpb24gc3BhY2UuDQo+ID4NCj4gPiBUaGlzIGlzIGV4YWN0bHkgd2hhdCB3ZSBkby4g
V2UgZG9u4oCZdCBmdXp6IGZyb20gdGhlIFBDSSBjb25maWcgc3BhY2UsDQo+ID4gd2Ugc3VwcGx5
IGlucHV0cyBmcm9tIHRoZSBob3N0L3ZtbSB2aWEgdGhlIGxlZ2l0aW1hdGUgaW50ZXJmYWNlcyB0
aGF0DQo+ID4gaXQgY2FuIGluamVjdCB0aGVtIHRvIHRoZSBndWVzdDogd2hlbmV2ZXIgZ3Vlc3Qg
cmVxdWVzdHMgYSBwY2kgY29uZmlnDQo+ID4gc3BhY2UgKHdoaWNoIGlzIGNvbnRyb2xsZWQgYnkg
aG9zdC9oeXBlcnZpc29yIGFzIHlvdSBzYWlkKSByZWFkDQo+ID4gb3BlcmF0aW9uLCBpdCBnZXRz
IGlucHV0IGluamVjdGVkIGJ5IHRoZSBrYWZsIGZ1enplci7CoCBTYW1lIGZvciBvdGhlcg0KPiA+
IGludGVyZmFjZXMgdGhhdCBhcmUgdW5kZXIgY29udHJvbCBvZiBob3N0L1ZNTSAoTVNScywgcG9y
dCBJTywgTU1JTywNCj4gPiBhbnl0aGluZyB0aGF0IGdvZXMgdmlhICNWRSBoYW5kbGVyIGluIG91
ciBjYXNlKS4gV2hlbiBpdCBjb21lcyB0bw0KPiA+IHZpcnRpbywgd2UgZW1wbG95ICB0d28gZGlm
ZmVyZW50IGZ1enppbmcgdGVjaG5pcXVlczogZGlyZWN0bHkNCj4gPiBpbmplY3Rpbmcga2FmbCBm
dXp6IGlucHV0IHdoZW4gdmlydGlvIGNvcmUgb3IgdmlydGlvIGRyaXZlcnMgZ2V0cyB0aGUNCj4g
PiBkYXRhIHJlY2VpdmVkIGZyb20gdGhlIGhvc3QgKHZpYSBpbmplY3RpbmcgaW5wdXQgaW4gZnVu
Y3Rpb25zDQo+ID4gdmlydGlvMTYvMzIvNjRfdG9fY3B1IGFuZCBvdGhlcnMpIGFuZCBkaXJlY3Rs
eSBmdXp6aW5nIERNQSBtZW1vcnkNCj4gPiBwYWdlcyB1c2luZyBrZnggZnV6emVyLiBNb3JlIGlu
Zm9ybWF0aW9uIGNhbiBiZSBmb3VuZCBpbg0KPiA+IGh0dHBzOi8vaW50ZWwuZ2l0aHViLmlvL2Nj
Yy1saW51eC1ndWVzdC1oYXJkZW5pbmctZG9jcy90ZHgtZ3Vlc3QtDQo+IGhhcmRlbmluZy5odG1s
I3RkLWd1ZXN0LWZ1enppbmcNCj4gDQo+IEdpdmVuIHRoYXQgd2UgcHJldmlvdXNseSBhZ3JlZWQg
dGhhdCBvcHBzZXMgYW5kIG90aGVyIERvUyBhdHRhY2tzIGFyZQ0KPiBvdXQgb2Ygc2NvcGUgZm9y
IENDLCBJIHJlYWxseSBkb24ndCB0aGluayBmdXp6aW5nLCB3aGljaCBwcmltYXJpbHkNCj4gZmlu
ZHMgb29wc2VzLCBpcyBhdCBhbGwgYSB1c2VmdWwgdG9vbCB1bmxlc3MgeW91IGZpbHRlciB0aGUg
cmVzdWx0cyBieQ0KPiB0aGUgcXVlc3Rpb24gImNvdWxkIHdlIGV4cGxvaXQgdGhpcyBpbiBhIEND
IFZNIHRvIHJldmVhbCBzZWNyZXRzIi4NCj4gV2l0aG91dCBhcHBseWluZyB0aGF0IGZpbHRlciB5
b3UncmUgc2VuZGluZyBhIGxvYWQgb2YgcGF0Y2hlcyB3aGljaA0KPiBkb24ndCByZWFsbHkgZG8g
bXVjaCB0byByZWR1Y2UgdGhlIENDIGF0dGFjayBzdXJmYWNlIGFuZCB3aGljaCBkbyBhbm5veQ0K
PiBub24tQ0MgcGVvcGxlIGJlY2F1c2UgdGhleSBhZGQgcG9pbnRsZXNzIGNoZWNrcyB0byB0aGlu
Z3MgdGhleSBleHBlY3QNCj4gdGhlIGNhcmRzIGFuZCBjb25maWcgdGFibGVzIHRvIGdldCByaWdo
dC4NCg0KSSBkb27igJl0IHRoaW5rIHdlIGhhdmUgYWdyZWVkIHRoYXQgcmFuZG9tIGtlcm5lbCBj
cmFzaGVzIGFyZSBvdXQgb2Ygc2NvcGUgaW4gQ0MgdGhyZWF0IG1vZGVsDQooY29udHJvbGxlZCBz
YWZlIHBhbmljIGlzIG91dCBvZiBzY29wZSwgYnV0IHRoaXMgaXMgbm90IHdoYXQgd2UgaGF2ZSBo
ZXJlKS4gDQpJdCBhbGwgZGVwZW5kcyBpZiB0aGlzIG9wcyBjYW4gYmUgdXNlZCBpbiBhIHN1Y2Nl
c3NmdWwgYXR0YWNrIGFnYWluc3QgZ3Vlc3QgcHJpdmF0ZQ0KbWVtb3J5IG9yIG5vdCBhbmQgdGhp
cyBpcyAqbm90KiBhIHRyaXZpYWwgdGhpbmcgdG8gZGVjaWRlLg0KVGhhdCdzIHNhaWQsIHdlIGFy
ZSBtb3N0bHkgZm9jdXNpbmcgb24gS0FTQU4gZmluZGluZ3MsIHdoaWNoDQpoYXZlIGhpZ2hlciBs
aWtlbGlob29kIHRvIGJlIGV4cGxvaXRhYmxlIGF0IGxlYXN0IGZvciBob3N0IC0+IGd1ZXN0IHBy
aXZpbGVnZSBlc2NhbGF0aW9uDQood2hpY2ggaW4gdHVybiBjb21wcm9taXNlZCBndWVzdCBwcml2
YXRlIG1lbW9yeSBjb25maWRlbnRpYWxpdHkpLiBGdXp6aW5nIGhhcyBhDQpsb25nIGhpc3Rvcnkg
b2YgZmluZCBzdWNoIGlzc3VlcyBpbiBwYXN0IChpbmNsdWRpbmcgdGhlIG9uZXMgdGhhdCBoYXZl
IGJlZW4gDQpleHBsb2l0ZWQgYWZ0ZXIpLiBCdXQgZXZlbiBmb3IgdGhpcyBvcHMgYnVnLCBjYW4g
YW55b25lIGd1YXJhbnRlZSBpdCBjYW5ub3QgYmUgY2hhaW5lZA0Kd2l0aCBvdGhlciBvbmVzIHRv
IGNhdXNlIGEgbW9yZSBjb21wbGV4IHByaXZpbGVnZSBlc2NhbGF0aW9uIGF0dGFjaz8gSSB3b250
IGJlIG1ha2luZyANCnN1Y2ggYSBjbGFpbSwgSSBmZWVsIGl0IGlzIHNhZmVyIHRvIGZpeCB0aGlz
IHZzIGRlYmF0aW5nIHdoZW5ldmVyIGl0IGNhbiBiZSB1c2VkIGZvciBhbg0KYXR0YWNrIG9yIG5v
dC4gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0KDQoNCg0K
