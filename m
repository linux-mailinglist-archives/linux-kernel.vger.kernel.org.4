Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00DC67C585
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjAZIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjAZIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:08:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F1B29E14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674720516; x=1706256516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kznA57safillIRET95gYVL9cUxZbepuIc/HwmHpD8j0=;
  b=iCH5isGmC+CiqgWRDKKtOJNBgY0vFTyMETqNUmNV42ifjJb+r6qjU3NT
   GvK/QILC2IHm1lOS1lgVzPgoGtFNv9UV+PzkhlG0HH5hxfxTGirzRUkpa
   X61+gyYj/SBVe6h2CpK3lIvY7/fSKcpg1GwOiDAfOquGlJkRaHUD45hR1
   z+fLkTzuFk+eQqu3IpgnqtuNBGJLRXR3jCbM0AN5l5Kfv5t3EH8V2UsgO
   6QsU9pL9uuwn4MGXwNZ7lrPfBZkeJgBf0OGtM3fp88OjmpbrNgopSa8vc
   tqlJNjUuoU1LiGDAZG9H4zbsWBIYvT1wsN65oC7pm04fVAlJnCvcf6/ZE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310343720"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="310343720"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 00:08:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="771049716"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="771049716"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2023 00:08:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 00:08:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 00:08:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 00:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZW6G0xZAhBNHc6q/Dgy7oBgc2oJd9DhaQVdM9yeKH0zbU4y5MP+sxS0gWYflrQTtJOL6CDlJ3RAEbKRRIFlJ50R4IafJhahDnCDfgeTQ5EgujRCuZ3CPC/NW3KKTBUlmlsl90v3/JMIGeDgGkHHtBTvAFTt2hfj9bQnHDKRRZb25uqPINqbHds0ajFCuyy+Wl9534CK4O4cocs6CIwfHb3wWpCqZCZ9/N+k/JaRAORAFVn8RxxoytnWIbJG48hWnlo/z66RpAf44+l6GEb2WMGWm5FDd5ny4i9qgi8GRFKmwpAYqZDQgi8D+A7trJfOyqrz3xMTBMAZYYtaCY3nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kznA57safillIRET95gYVL9cUxZbepuIc/HwmHpD8j0=;
 b=OlN1vAwVA9lhURpDDQuzm0XobcBcxgCYoEhDAHGtdgYEMQE3FwxrCadS+gLcsXI8rhoe52ncmvLg+n7w3dYU7mh2sf1/AagleI18IBK8b/gKljiNSifsfwekspfV153SUlFObqeodX5zE4OUwxagMNOqSLfYfpNlcu3y2yvaB5Y3KAITtuLEXT0EiU4wehyt11wCrPHR8hW9S/w7cHuOAWdVwvVaDdK+AVtk0B0TKmjhGhlX7SyuzR/ohqpx/xkP4aW76Lg2UWvTz3OvnaITD7KIYBWJOxU2btkQgsrFuyuUYybs/nSlZryW5/y/MGiCk6tHiYdGwm71BJD6G0Esaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BN9PR11MB5337.namprd11.prod.outlook.com (2603:10b6:408:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 08:08:27 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 08:08:27 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
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
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAA9DVAAAeQIHQ
Date:   Thu, 26 Jan 2023 08:08:27 +0000
Message-ID: <DM8PR11MB5750093F4CC04ED8EC50EA9CE7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9FbjjpVTt/Yp0lq@mit.edu>
In-Reply-To: <Y9FbjjpVTt/Yp0lq@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BN9PR11MB5337:EE_
x-ms-office365-filtering-correlation-id: 417989dd-2747-4ae6-b71b-08daff74814f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pO3l3+FbANGdUgLKf0z0E8BvmRQ5O2lFE3TJWUz1NFW4u3enJ/ULtvaQ+igzam2XrShPbKZUmvhttK1YmVidfTbUatRSlMM2KuhcOCelv4CrDBfBmRUlMcKngxqz3eQB9k4GGAHLozC096y+DUNIHPYe/WdqlUT/orSunaIor3AUmqP9flHNI097I1jYh6xSsZ5bL+6dXaxuABE0uiCLDEJ/N7gaRfxJH+tM0bj+fRy9k2FdcKQ+mWFO5KYOhuI86gdrFe+p+UDhlKiJJzJb6qXxpkqMevzfrYPG+ZTE5cYtmTvzBWpL1lXgM4a+sEjOLFKv1taB5zfj+Krtkc+E1kOeS+0UddleSos+pnUwyEvnQIwdh/3faE32s9CgbNL/Q0YLU1wnC3KURT6WPBvrS946tspX46j4QqR5Gl2mR73XAHAZmvTJsfIz8bfag6j519A/hpvv3y/EjLZw4N5eOgCdSH43ojZiniheqoXSvG/y66IT5NCROKE4IRFnv4uErpgr2Ot4mt670sU4nASfvtSxVFcVmFRe6eQMSOAzLUIAkTyE5qEIbk+CU+Z90RzAWbY9MAbjU+WkAKZ8ASsooTL7ns8X7rWdtIM84/y4uwfPSbCBdYPHYkjl92rPZm5yGaYuq6+aQ2XQnWUSoHbwFmmyadjJkzo2oDOLFtTiRDWEjDN4MuthliyEPaanBcB8iGxZOEHWDyF7ukmHje6UWewFj506TDCBLpvtlRyPlY17WOZpHtrwlAXVPqx54wpGB9/yPEa1IcTSIgg3p2jnHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(33656002)(71200400001)(8676002)(7696005)(54906003)(316002)(6506007)(478600001)(966005)(5660300002)(7416002)(2906002)(66446008)(4326008)(76116006)(66946007)(6916009)(66476007)(66556008)(64756008)(52536014)(8936002)(41300700001)(82960400001)(38070700005)(86362001)(55016003)(38100700002)(122000001)(83380400001)(186003)(9686003)(26005)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3BtVEpYZURDRG9sL3ZvSllPNU0zU3d4ZG5JYXMxZlh2aHR1RTkwczgxTjYr?=
 =?utf-8?B?VWt3OG1LU2ZSWU5xdExIdjVBbk1hOTR3N2RmQldHWWdnQXVubytzMUFBZEtE?=
 =?utf-8?B?bCtFMXQzYXBQNmFGNlExTmtOWHdEYnhVSlBjR1JNc1lsMXoxUm1SLyt3d2l1?=
 =?utf-8?B?NXlwU01KUkl2S3FGUG1IMUJLQldVTGNuenBkVWRVQXVrZE1seEozN2JvSHgz?=
 =?utf-8?B?K1g2NlFYdkxtazB1S1QzV2hXLy9PcnZEeWFrRjFNdWQ1b1ZGNUZKektwQXBh?=
 =?utf-8?B?N0o0eG00SEc5amFPZWQ5aW5pNnFvSUk4ckF0cTR2Tnp0N1FKbHJVeEpiUjBN?=
 =?utf-8?B?T3hEdHk0cUh4MWk3YjUzN1gxNVBXQ3JvTVl1SDRCbTJ2dVlQaTh2VmRsRWlK?=
 =?utf-8?B?aEVkN0FTWEJOR1Q3SE9MeDE2WU9ZRVlHS2t1NldHdGMzUVk0OTdjZ0dzelp4?=
 =?utf-8?B?eXgzTVJJb0svQ28zay9MOWZ4T1dKZXNnQ3dwdHBlKzBTL3RLQkJ4dC9RMzNv?=
 =?utf-8?B?QTdLdEZhRVV1ZkkrTlVSbnR3cWxLWkI0RE5YaS9RY2dmN2tIRmZhTkRaeito?=
 =?utf-8?B?dUxiOHFKKysvSEliUFF2eHdla3JXcXJOUDVTaWRjekY3aGdJWkFKclYrRzFq?=
 =?utf-8?B?eFRtQTJKOC9UQkdjdWxIMnptM2R1RzNGQktSS2diT2FwdjI3Z0VzcWdRaTIr?=
 =?utf-8?B?cXozS0trelJyWk04Z1NuMnh5VHFKREhjLzFXb0czaWgzRlpTdE1JYmN1eW9t?=
 =?utf-8?B?dTNmYzd0QlhPTlk4R3lFYVNZdmlqUHArN3lvTktiTDVMd293a1RHc3MzRWpF?=
 =?utf-8?B?STZraGVQcU5jTEY0blJzQUREc2FnekNKZTVITWlIcmhFdFR0Q0hwNzFxaHMz?=
 =?utf-8?B?WGp2ZzhvejNjTXArVngwL1pNQVpIUDRPU1VYK3Yvcnpwa1dieTExVFhaeDAr?=
 =?utf-8?B?NFZ2bjN1TEhPdVBZekk5ZFd6UnFBbGdPMWJFRWM1UmQ3NWhvYzB0dmJIMndO?=
 =?utf-8?B?ZkUwd3dSNEZLT3F3RjNOaE1XeHZCMXFSdVV1cGtqRXpIMWRoR3BBc0RCK2ZP?=
 =?utf-8?B?TU1hZDJsR3hnYngvWnV6VDBBdzZpZmMrQmIvbzhaUGQxY1RLSS9qTVBOV09s?=
 =?utf-8?B?WUFoalJYMGdxSnNqWkdQa0tWc1k2eWVrNm1iZGRxU2duOWlBRnhJZXFVN3Nk?=
 =?utf-8?B?bzg1enZUT0QvaUhEcVpIdlRDRUE0Mjl6b3V4Uk5iR01qM1NIQWEzVERWR055?=
 =?utf-8?B?WlBISGliRVJrMnNEdDV2REY3U3VGcVV2VXMyT1ZCY3BOcEdPUC9HdjJVNGdo?=
 =?utf-8?B?YlhUMUxkbGRwNkNxcVdYTlNSRHROc3NpdmJnY0lTVTFjNGdLcHJSNkFVelpF?=
 =?utf-8?B?Y3F6UnA4c0JhUGRBUlJnd2VBc29LcklacE9XWmovejRSVU1qRVorNTFkMFZs?=
 =?utf-8?B?cTZlVkFJWFhNM3IrUktLOHZJMXE4Mm5lUm52NlhkZUwyNjVTQ3dNMkNNeDBM?=
 =?utf-8?B?ODJxcHZ5WjJyd3NUeVRsRGxVVEZ5MWRvL2t4dDViTDdnVVllS3FXakFSZjJ6?=
 =?utf-8?B?ZWFQa2hDY2NYR2Z3VDd5K3pTdXUvbHp4TUhjNURXLzdDbFRpclVpZUcyM1Bv?=
 =?utf-8?B?YmFISk5nbkxsb2Y4SjY2YWZad1prK1BlMis1alVTZTZmQ1V1RlZFWDE1cmV6?=
 =?utf-8?B?emZIRU5LVFl5UDd0VXRsc3JSS3hLNzlsV0xWSkxZRWhpaDhkRGhEV0FScVAw?=
 =?utf-8?B?NjE5dVRidDVGYW9jTE5GVllYZ0dSOWJiT3NCSTBJUitrblJFclpZRmtpVS9H?=
 =?utf-8?B?MEtiK1ZMb0NlSHFFS3ZWY2dHNThyZXAxWVJ3a21SMHBla1p4RkNiQThrcDBL?=
 =?utf-8?B?clNQdzVzRmVzT0xaaEl2OUxLaWpOeEEvZlRuemRNblFlandWYU5rMWJxNDg5?=
 =?utf-8?B?M1hRK2lXdjBqSXZXVFhnU1hxSjBVRHBCVTAxbWU2QkdSY3RTaEJrNG82MTFi?=
 =?utf-8?B?d0syUVJPMjFKZjhxSko3UjhIbnkzTFhtMGpvenRyV1lseVZ1QmVHN3hzdDNp?=
 =?utf-8?B?Ui9sSHJPUTlEcW1UMFZXZDE5TFc0MXc2WFh1ZVl2bjhLRm0wNEpRNFd6R09I?=
 =?utf-8?Q?KXf184ZdLHHJyI3oagmDm0qov?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417989dd-2747-4ae6-b71b-08daff74814f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 08:08:27.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Opes+CQ4/MekZ4L1dvimjSP306lzeNIiOnUzMX+hxvdXKkyv1U8azmKV3dvSnSMXsLjmVko11v20jBaf0cSwa3QfuXKGhcUzPl3ThN2s7VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQogT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgMDM6Mjk6MDdQTSArMDAwMCwgUmVzaGV0b3ZhLCBF
bGVuYSB3cm90ZToNCj4gPiA+IEFnYWluLCBhcyBvdXIgZG9jdW1lbnRhdGlvbiBzdGF0ZXMsIHdo
ZW4geW91IHN1Ym1pdCBwYXRjaGVzIGJhc2VkIG9uDQo+ID4gPiB0aGVzZSB0b29scywgeW91IEhB
VkUgVE8gZG9jdW1lbnQgdGhhdC4gIE90aGVyd2lzZSB3ZSB0aGluayB5b3UgYWxsIGFyZQ0KPiA+
ID4gY3JhenkgYW5kIHdpbGwgZ2V0IHlvdXIgcGF0Y2hlcyByZWplY3RlZC4gIFlvdSBhbGwga25v
dyB0aGlzLCB3aHkgaWdub3JlDQo+ID4gPiBpdD8NCj4gPg0KPiA+IFNvcnJ5LCBJIGRpZG7igJl0
IGtub3cgdGhhdCBmb3IgZXZlcnkgYnVnIHRoYXQgaXMgZm91bmQgaW4gbGludXgga2VybmVsIHdo
ZW4NCj4gPiB3ZSBhcmUgc3VibWl0dGluZyBhIGZpeCB0aGF0IHdlIGhhdmUgdG8gbGlzdCB0aGUg
d2F5IGhvdyBpdCBoYXMgYmVlbiBmb3VuZC4NCj4gPiBXZSB3aWxsIGZpeCB0aGlzIGluIHRoZSBm
dXR1cmUgc3VibWlzc2lvbnMsIGJ1dCBzb21lIGJ1Z3Mgd2UgaGF2ZSBhcmUgZm91bmQgYnkNCj4g
PiBwbGFpbiBjb2RlIGF1ZGl0LCBzbyAnaHVtYW4nIGlzIHRoZSB0b29sLg0KPiANCj4gU28gdGhl
IGNvbmNlcm4gaXMgdGhhdCAqeW91KiBtYXkgdGhpbmsgaXQgaXMgYSBidWcsIGJ1dCBvdGhlciBw
ZW9wbGUNCj4gbWF5IG5vdCBhZ3JlZS4gIFBlcmhhcHMgd2hhdCBpcyBuZWVkZWQgaXMgYSBmdWxs
IGRlc2NyaXB0aW9uIG9mIHRoZQ0KPiBnb2FscyBvZiBDb25maWRlbnRpYWwgQ29tcHV0aW5nLCBh
bmQgd2hhdCBpcyBpbiBzY29wZSwgYW5kIHdoYXQgaXMNCj4gZGVsaWJlcmF0ZWx5ICpub3QqIGlu
IHNjb3BlLiAgSSBwcmVkaWN0IHRoYXQgd2hlbiB5b3UgZG8gdGhpcywgdGhhdA0KPiBwZW9wbGUg
d2lsbCBjb21lIG91dCBvZiB0aGUgd29vZCB3b3JrIGFuZCBzYXksIG5vIHdhaXQsICJDb0NvIGFs
YQ0KPiBTLzM5MCBtZWFucyBGT08iLCBhbmQgIkNvQ28gYWxhIEFNRCBtZWFucyBCQVIiLCBhbmQg
IkNvQ28gYWxhIFJJU0MgVg0KPiBtZWFucyBRVVVYIi4NCg0KQWdyZWUsIGFuZCB0aGlzIGlzIHRo
ZSByZWFzb24gYmVoaW5kIHN0YXJ0aW5nIHRoaXMgdGhyZWFkOiB0byBtYWtlIHN1cmUgcGVvcGxl
DQphZ3JlZSBvbiB0aGUgdGhyZWF0IG1vZGVsLiAgVGhlIG9ubHkgcmVhc29uIHdoeSB3ZSBzdWJt
aXR0ZWQgc29tZSB0cml2aWFsIGJ1Z3MNCmZpeGVzIHNlcGFyYXRlbHkgaXMgdGhlIGZhY3QgdGhh
dCB0aGV5ICphbHNvKiBjYW4gYmUgY29uc2lkZXJlZCBidWdzIHVuZGVyIGV4aXN0aW5nDQp0aHJl
YXQgbW9kZWwsIGlmIG9uZSB0aGlua3MgdGhhdCBrZXJuZWwgc2hvdWxkIGJlIGFzIHJvYnVzdCBh
cyBwb3NzaWJsZSBhZ2FpbnN0IA0KcG90ZW50aWFsIGVycm9uZW91cyBkZXZpY2VzLg0KDQpBcyBk
ZXNjcmliZWQgcmlnaHQgaW4gdGhlIGJlZ2lubmluZyBvZiB0aGUgZG9jIEkgc2hhcmVkIFsxXSAo
YWRqdXN0ZWQgbm93IHRvIHJlbW92ZQ0KJ1REWCcgYW5kIHB1dCBnZW5lcmljICdDQyBndWVzdCBr
ZXJuZWwnKSwgd2Ugd2FudCB0byBtYWtlIHN1cmUgdGhhdCBhbiB1bnRydXN0ZWQNCmhvc3QgKGFu
ZCBoeXBlcnZpc29yKSBpcyBub3QgYWJsZSB0bw0KDQoxLiBhcmNoaXZlIHByaXZpbGVnZWQgZXNj
YWxhdGlvbiBpbnRvIGEgQ0MgZ3Vlc3Qga2VybmVsDQoyLiAgY29tcHJvbWlzZSB0aGUgY29uZmlk
ZW50aWFsaXR5IG9yIGludGVncml0eSBvZiBDQyBndWVzdCBwcml2YXRlIG1lbW9yeQ0KDQpUaGUg
YWJvdmUgc2VjdXJpdHkgb2JqZWN0aXZlcyBnaXZlIHVzIHR3byBwcmltYXJ5IGFzc2V0cyB3ZSB3
YW50IHRvIHByb3RlY3Q6DQpDQyBndWVzdCBleGVjdXRpb24gY29udGV4dCBhbmQgQ0MgZ3Vlc3Qg
cHJpdmF0ZSBtZW1vcnkgY29uZmlkZW50aWFsaXR5IGFuZA0KaW50ZWdyaXR5LiANCg0KVGhlIERv
UyBmcm9tIHRoZSBob3N0IHRvd2FyZHMgQ0MgZ3Vlc3QgaXMgZXhwbGljaXRseSBvdXQgb2Ygc2Nv
cGUgYW5kIGEgbm9uLXNlY3VyaXR5DQpvYmplY3RpdmUuIA0KDQpUaGUgYXR0YWNrIHN1cmZhY2Ug
aW4gcXVlc3Rpb24gaXMgYW55IGludGVyZmFjZSBleHBvc2VkIGZyb20gYSBDQyBndWVzdCBrZXJu
ZWwNCnRvd2FyZHMgdW50cnVzdGVkIGhvc3QgdGhhdCBpcyBub3QgY292ZXJlZCBieSB0aGUgQ0Mg
SFcgcHJvdGVjdGlvbnMuIEhlcmUgdGhlDQpleGFjdCBsaXN0IGNhbiBkaWZmZXIgc29tZXdoYXQg
ZGVwZW5kaW5nIG9uIHdoYXQgdGVjaG5vbG9neSBpcyBiZWluZyB1c2VkLCBidXQgYXMNCkRhdmlk
IGFscmVhZHkgcG9pbnRlZCBvdXQgYmVmb3JlOiBib3RoIENDIGd1ZXN0IG1lbW9yeSBhbmQgcmVn
aXN0ZXIgc3RhdGUgaXMNCnByb3RlY3RlZCBmcm9tIGhvc3QgYXR0YWNrcywgc28gd2UgYXJlIGZv
Y3VzaW5nIG9uIG90aGVyIGNvbW11bmljYXRpb24gY2hhbm5lbHMNCmFuZCBvbiBnZW5lcmljIGlu
dGVyZmFjZXMgdXNlZCBieSBMaW51eCB0b2RheS4gDQoNCkV4YW1wbGVzIG9mIHN1Y2ggaW50ZXJm
YWNlcyBmb3IgVERYIChhbmQgSSB0aGluayBTRVYgc2hhcmVzIG1vc3Qgb2YgdGhlbSwgYnV0IHBs
ZWFzZQ0KY29ycmVjdCBtZSBpZiBJIGFtIHdyb25nIGhlcmUpIGFyZSBhY2Nlc3MgdG8gc29tZSBN
U1JzIGFuZCBDUFVJRHMsIHBvcnQgSU8sIE1NSU8NCmFuZCBETUEsIGFjY2VzcyB0byBQQ0kgY29u
ZmlnIHNwYWNlLCBLVk0gaHlwZXJjYWxscyAoaWYgaHlwZXJ2aXNvciBpcyBLVk0pLCBURFggc3Bl
Y2lmaWMNCmh5cGVyY2FsbHMgKHRoaXMgaXMgdGVjaG5vbG9neSBzcGVjaWZpYyksIGRhdGEgY29u
c3VtZWQgZnJvbSB1bnRydXN0ZWQgaG9zdCBkdXJpbmcgdGhlDQpDQyBndWVzdCBpbml0aWFsaXph
dGlvbiAoaW5jbHVkaW5nIGtlcm5lbCBpdHNlbGYsIGtlcm5lbCBjb21tYW5kIGxpbmUsIHByb3Zp
ZGVkIEFDUEkgdGFibGVzLCANCmV0YykgYW5kIG90aGVycyBkZXNjcmliZWQgaW4gWzFdLg0KQW4g
aW1wb3J0YW50IG5vdGUgaGVyZSBpcyB0aGF0IHRoZXNlIGludGVyZmFjZXMgYXJlIG5vdCBsaW1p
dGVkIGp1c3QgdG8gZGV2aWNlIGRyaXZlcnMNCihhbGJlaXQgZGV2aWNlIGRyaXZlcnMgYXJlIHRo
ZSBiaWdnZXN0IHVzZXJzIGZvciBzb21lIG9mIHRoZW0pLCB0aGV5IGFyZSBwcmVzZW50IHRocm91
Z2ggdGhlIHdob2xlIA0Ka2VybmVsIGluIGRpZmZlcmVudCBzdWJzeXN0ZW1zIGFuZCBuZWVkIGNh
cmVmdWwgZXhhbWluYXRpb24gYW5kIGRldmVsb3BtZW50IG9mIA0KbWl0aWdhdGlvbnMuIA0KDQpU
aGUgcG9zc2libGUgcmFuZ2Ugb2YgbWl0aWdhdGlvbnMgdGhhdCB3ZSBjYW4gYXBwbHkgaXMgYWxz
byB3aWRlLCBidXQgeW91IGNhbiByb3VnaGx5IHNwbGl0IGl0IGludG8NCnR3byBncm91cHM6IA0K
DQoxLiBtaXRpZ2F0aW9ucyB0aGF0IHVzZSB2YXJpb3VzIGF0dGVzdGF0aW9uIG1lY2hhbmlzbXMg
KHdlIGNhbiBhdHRlc3QgdGhlIGtlcm5lbCBjb2RlLA0KY21saW5lLCBBQ1BJIHRhYmxlcyBiZWlu
ZyBwcm92aWRlZCBhbmQgb3RoZXIgcG90ZW50aWFsIGNvbmZpZ3VyYXRpb25zLCBhbmQgb25lIGRh
eSB3ZSANCndpbGwgaG9wZWZ1bGx5IGFsc28gYmUgYWJsZSB0byBhdHRlc3QgZGV2aWNlcyB3ZSBj
b25uZWN0IHRvIENDIGd1ZXN0IGFuZCB0aGVpciBjb25maWd1cmF0aW9uKQ0KDQoyLiBvdGhlciBt
aXRpZ2F0aW9ucyBmb3IgdGhyZWF0cyB0aGF0IGF0dGVzdGF0aW9uIGNhbm5vdCBjb3ZlciwgaS5l
LiBtYWlubHkgcnVudGltZSANCmludGVyYWN0aW9ucyB3aXRoIHRoZSBob3N0LiANCg0KQWJvdmUg
c291bmRzIGNvbmNlcHR1YWxseSBzaW1wbGUgYnV0IHRoZSBkZXZpbCBpcyBhcyB1c3VhbCBpbiBk
ZXRhaWxzLCBidXQgaXQgZG9lc27igJl0IGxvb2sNCnZlcnkgaW1wb3NzaWJsZSBvciBzbXRoIHRo
YXQgd291bGQgbmVlZCB0aGUgKioqaW5zYW5lKioqIGNoYW5nZXMgdG8gdGhlIGVudGlyZSBrZXJu
ZWwuDQoNCj4gDQo+IE90aGVycyBtYXkgZW5kIHVwIG9iamVjdGluZywgIm5vIHdhaXQsIGRvaW5n
IHRoaXMgaXMgZ29pbmcgdG8gbWVhbg0KPiAqKippbnNhbmUqKiogY2hhbmdlcyB0byB0aGUgZW50
aXJlIGtlcm5lbCwgYW5kIHRoaXMgd2lsbCBiZSBhDQo+IHBlcmZvcm1hbmNlIC8gbWFpbnRlbmFu
Y2UgbmlnaHRtYXJlIGFuZCB1bmxlc3MgeW91IGZpeCB5b3VyIGhhcmR3YXJlDQo+IGluIGZ1dHVy
ZSBjaGlwcywgd2Ugd2xpbCBjb25zaWRlciB0aGlzIGEgaGFyZHdhcmUgYnVnIGFuZCByZWplY3Qg
YWxsDQo+IG9mIHlvdXIgcGF0Y2hlcyIuDQo+IA0KPiBCdXQgaXQncyBiZXR0ZXIgdG8gZmlndXJl
IHRoaXMgb3V0IG5vdywgdGhlbiBhZnRlciB5b3UgZ2V0IGh1bmRyZWRzIG9mDQo+IHBhdGNoZXMg
aW50byB0aGUgdXBzdHJlYW0ga2VybmVsLCB3ZSBkaXNjb3ZlciB0aGF0IHRoaXMgaXMgb25seSA1
JSBvZg0KPiB0aGUgbmVjZXNzYXJ5IGNoYW5nZXMsIGFuZCB0aGVuIHRoZSByZXN0IG9mIHlvdXIg
cGF0Y2hlcyBhcmUgcmVqZWN0ZWQsDQo+IGFuZCB5b3UgaGF2ZSB0byBlbmQgdXAgZml4aW5nIHRo
ZSBoYXJkd2FyZSBhbnl3YXksIHdpdGggdGhlIHBhdGNoZXMNCj4gdXBzdHJlYW1lZCBzbyBmYXIg
YmVpbmcgd2FzdGVkIGVmZm9ydC4gIDotKQ0KPiANCj4gSWYgd2UgZ2V0IGNvbnNlbnN1cyBvbiB0
aGF0IGRvY3VtZW50LCB0aGVuIHRoYXQgY2FuIGdldCBjaGVja2VkIGludG8NCj4gRG9jdW1lbnRh
dGlvbiwgYW5kIHRoYXQgY2FuIHJlcHJlc2VudCBnZW5lcmFsIGNvbnNlbnN1cyBvbiB0aGUgcHJv
YmxlbQ0KPiBlYXJseSBvbi4NCg0KU3VyZSwgSSBhbSB3aWxsaW5nIHRvIHdvcmsgb24gdGhpcyBz
aW5jZSB3ZSBhbHJlYWR5IHNwZW50IHF1aXRlIGEgbG90IG9mIGVmZm9ydA0KbG9va2luZyBpbnRv
IHRoaXMgcHJvYmxlbS4gTXkgb25seSBxdWVzdGlvbiBpcyBob3cgdG8gb3JnYW5pemUgYSByZXZp
ZXcgb2Ygc3VjaA0KZG9jdW1lbnQgaW4gYSBzYW5lIGFuZCBwcm9kdWN0aXZlIHdheSBhbmQgdG8g
bWFrZSBzdXJlIGFsbCByZWxldmFudCBwZW9wbGUNCmFyZSBpbmNsdWRlZCBpbnRvIGRpc2N1c3Np
b24uIEFzIEkgc2FpZCwgdGhpcyBzcGF3bnMgYWNyb3NzIG1hbnkgYXJlYXMgaW4ga2VybmVsLA0K
YW5kIGlkZWFsbHkgeW91IHdvdWxkIHdhbnQgZGlmZmVyZW50IHBlb3BsZSByZXZpZXcgdGhlaXIg
YXJlYSBpbiBkZXRhaWwuIA0KRm9yIGV4YW1wbGUsIG9uZSBvZiBtYW55IGFzcGVjdHMgd2UgbmVl
ZCB0byB3b3JyeSBpcyBzZWN1cml0eSBvZiBDQyBndWVzdCBMUk5HICgNCmVzcGVjaWFsbHkgaW4g
Y2FzZXMgd2hlbiB3ZSBkb27igJl0IGhhdmUgYSB0cnVzdGVkIHNlY3VyaXR5IEhXIHNvdXJjZSBv
ZiBlbnRyb3B5KQ0KWzJdIGFuZCBoZXJlIGEgZmVlZGJhY2sgZnJvbSBMUk5HIGV4cGVydHMgd291
bGQgYmUgaW1wb3J0YW50LiANCg0KSSBndWVzcyB0aGUgZmlyc3QgY2xlYXIgc3RlcCBJIGNhbiBk
byBpcyB0byByZS13cml0ZSB0aGUgcmVsZXZhbnQgcGFydCBvZiBbMV0gIGludG8gYSBDQy10ZWNo
bm9sb2d5DQpuZXV0cmFsIGxhbmd1YWdlIGFuZCB0aGVuIHdvdWxkIG5lZWQgZmVlZGJhY2sgYW5k
IGlucHV0IGZyb20gQU1EIGd1eXMgdG8gbWFrZSANCnN1cmUgaXQgY29ycmVjdGx5IHJlZmxlY3Rz
IHRoZWlyIGNhc2UgYWxzby4gV2UgY2FuIHByb2JhYmx5IGRvIHRoaXMgcHJlcGFyYXRpb24gd29y
ayANCm9uIGxpbnV4LWNvY28gbWFpbGluZyBsaXN0IGFuZCB0aGVuIHBvc3QgZm9yIGEgd2lkZXIg
cmV2aWV3PyANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQoNClsxXSBodHRwczovL2ludGVsLmdp
dGh1Yi5pby9jY2MtbGludXgtZ3Vlc3QtaGFyZGVuaW5nLWRvY3Mvc2VjdXJpdHktc3BlYy5odG1s
I3RocmVhdC1tb2RlbA0KWzJdIGh0dHBzOi8vaW50ZWwuZ2l0aHViLmlvL2NjYy1saW51eC1ndWVz
dC1oYXJkZW5pbmctZG9jcy9zZWN1cml0eS1zcGVjLmh0bWwjcmFuZG9tbmVzcy1pbnNpZGUtdGR4
LWd1ZXN0DQoNCj4gDQo+IAkJCQkJCS0gVGVkDQo=
