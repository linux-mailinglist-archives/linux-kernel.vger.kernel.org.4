Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5E667F00
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbjALTZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjALTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:25:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D369A3753C;
        Thu, 12 Jan 2023 11:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673550924; x=1705086924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3lI6U01xj+sqRZBpqCEWEHvh+8BBKw0Is+AMzYJ7bxc=;
  b=CEa0n42pigPBWzhPfiOozCXF05KaKGyvaVjHra2IPn0e7Vhl/uLC6ORt
   IAd4nJC5KtbtNnnb+1+Riagg10KZtqk9zwyRKNg6tMr4JL5e3Cp2Ebc+S
   8XQVd0HbZPjHQRzKSNCagC8xjIPPKEUcMOA77z5MDtmQXM16gJXqh7FvV
   KrE2SLfEQxwOEwYVCs7ZApwvYsWl2rRBVubuj2TqE5WjOCXsQV2cx5SbT
   VNl4ladiE86o5qOKnIAggxLZIR+Zd8ycJaMNJTtB6wRp9GoY85qF3KQ/y
   9GgA6r94PR8sbvvDRm0fa21Epn5DzHCCCDdTr8TvUlpUS/cWMVPaIF1OG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="321498464"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="321498464"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 11:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="657933893"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="657933893"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2023 11:15:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 11:15:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 11:15:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 11:15:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvlbL0q8N/jgjrPXBDBdCReH5fanJdIAb0U59Ow12UoMrMjh24HgEfNP3h9v7SPGP71RRrheGkKJBAyD6ZkVKa8HJ+VkDnN6730t/7FjgMqVz3I1OTLBUjMawEtwwOmtyuUVXywdtPnECMMc8EDMo2pJ1TImes71dZKt1nYbKHKWxTr+jEbK//4fiVH0WWIc1kCm78ccLf+lE6+smo91ebNSPOQfaAX04Bw1RgJ5kzhBTKlddcuIQaq8vCXHYeY8g2R9kFDgPWV8DiaFFzNIQ5aLS/gw4OEUftWfbCT6mh6bYgUz2Hqd0o45rnmb8h30kOU1NBfC7B1aVavoOSZEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lI6U01xj+sqRZBpqCEWEHvh+8BBKw0Is+AMzYJ7bxc=;
 b=Pg5jFW81Udy60HLfy35UiMba6vsdn5ENJ4NEUBdxsz/tEf3eJPNlxgbI5S+ju+xwh1D6Su1T0XOnyyRx8ur+3/CZ4a5XU5qK337ATmkzTf4RmpnhorYjgG8wD+1ZqIPDm0Z3Mt1fMajZnGpVezCPkBWs+kCamBrkRID6bEDQ/pqp7z6xN8sxfCxadR3a3wvycALG1kezblEBMIIf8/dX8i6PjGMK/Qoqlvkcoj4HOVVI1//aYmTO+PHM6eZdQ6e0fT/RgyTWL6jFs4mjXglbj4ouWUofFPfEMLKRzhmPcJz9Ls8z8MTxO0pvTaI83m9ElBOmEIgFIqY/UFjm53bExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 12 Jan
 2023 19:15:17 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 19:15:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Topic: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Index: AQHZJTksM0Lkm+QZIUqyvtSWxlR3AK6Zrh4AgAADCICAASUoAIAAU6cA
Date:   Thu, 12 Jan 2023 19:15:17 +0000
Message-ID: <0c7760bf5976cb64c952df5601eae14fd33fbe2e.camel@intel.com>
References: <20230110211839.19572-1-rick.p.edgecombe@intel.com>
         <CAJZ5v0jnp3jLdD1wN1NjMfxrt+gYZ+im_quHdgsOrWve0XQaWg@mail.gmail.com>
         <cd2a9ccec0d88821fb0c7580f7ae934f2de71ddf.camel@intel.com>
         <CAJZ5v0hffKjor=kzr71esaw7M2BV5vCTEY7pg67-iWXZ98sQBw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hffKjor=kzr71esaw7M2BV5vCTEY7pg67-iWXZ98sQBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB5148:EE_
x-ms-office365-filtering-correlation-id: d30b2917-5718-43b7-5677-08daf4d1572a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9K5tI59bGC+45ZVwWcif3fcvd9OMfjipRGglm3FKPxPocVi2HQJyVHRlAGdz/veOSgUUxCy3tv4zeYi3pOM9Yr4JSPKizuIbnQyEp3HlLYCq+4Uf7PACRFkyYy+hSyCU9ZI0TSXLt0/90wUfulMgJBcpSBfauJQVp9dVnNc19DdmGSZ7WmgdNA2RzXzIjcwmvEaKvIMIIBXnnmcLWAUzgLjoVFR1YlhdbqAYNUsHj7uLxC/bCtcVECDMqIz1vvUcAGBMi0t/KGYgg+gcqD7xVhG1wGJEO2DCrqishFjGJa4Xjm1pyhSAOQyLOFvtld2KZ2ULeSmnlVESZaoGKbQvGGm+c8DQ0vkfYyfKQe0PSHcmV+oybeG3AAjIQyDQj2sgTfYuwI2X/uUv35pXaZSnDtG03HXYJ6sPt1GUwgkVhnytKSAEOufGpPFBEnATLud5KyYxh9Dj3gZJKNlQ0rMQfHiOjpajkeGz5Ba3x5q9ITtZCadtr+PC9aFKHdejijq5pBusJcTK5qYbpiqy/FsrADysoKeiNVSFsi3oTqhEuNwOG4m+Pp5JJyohytvMA1kpj2YXzBR0XGACzqbupyJY42HBGozuSxZ+Mw2XNyXnZkENtbdWaRIU91Q66onPjA2K9AQ1P57bwd0VdxyfRhW7KHVMcUirWSabbsNsXc67F0UkptBIysxfiilSmyEqXIoJTLOcwShaJmMywR9p74LOCX1hJMJIV8Jd39hYglczPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199015)(2906002)(7416002)(5660300002)(8936002)(26005)(36756003)(41300700001)(186003)(6512007)(76116006)(66476007)(71200400001)(66946007)(91956017)(66446008)(64756008)(66556008)(38070700005)(86362001)(4326008)(6916009)(8676002)(38100700002)(82960400001)(122000001)(2616005)(478600001)(83380400001)(6486002)(6506007)(54906003)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SldTaTlBdGFYL1Evam1pTXQrYmxyTHpWN1pkTWhCcERrbWNVS2QzOFgwdUw2?=
 =?utf-8?B?ZHhEVmFaR3YxNG90VkFlWGVMNTRzb2RFOU05c2Zha09Kd0VYdzFOL00zUWg4?=
 =?utf-8?B?SVloOGJJNHZEbzZLSFpobDBvVHBnTUVTOExPcThUNUZBMW50RGpBMVROYndR?=
 =?utf-8?B?NEo3Qm1VdUxHQ2gzNEJ6bnNNNnd5KzNoUnZ0SWhjM28yeUZhZGs0VHZYUm42?=
 =?utf-8?B?VWNZYVFKY1FORm5VWTFOOUNPZ2RLYzFwd2xKL1FsUldIVGV2Ri95TU5KeXZI?=
 =?utf-8?B?MG4wNFBmdFZ1S25FaG9KV21BYVgrdVM4Z0hiRlFSWmZBRnUxa3Z6U2xrajhv?=
 =?utf-8?B?SUhTYlJnKytZYkNORjZ1ZVRxemFVcnRNWFVTZG5oQStGOURUSjFEeDdkVG5a?=
 =?utf-8?B?djM5QlI2ZGp2ZHk3RFVXdWJxZ2Y1NEZHSmZQQVZrRG4zUU1BNlVOd0lqcDVJ?=
 =?utf-8?B?eXIvNTBORGE2UURySWdIa2NTUUYxUjRDbHg0YldUa1liaG5PWHVVSlQ5T04x?=
 =?utf-8?B?NCtiNFIrN256UUd2bVlWK1ZxWFlGcEhwQWZqYTVPQUtiSTlNc3NmeDFsQnpL?=
 =?utf-8?B?aDZ1SHZPcWNzNnYvYnZqVTU3MENGenBWcU55UTRnZlV4bGhqTkYwS0grMHow?=
 =?utf-8?B?VFlxYXNYNW1LRGZnKzNFZW9iUjNGbFpQaENYRHJNV1c1YWt0cjR3R3BlRC8r?=
 =?utf-8?B?RTdZSEZFMzMwejVQTUo3OFFrRU13NGRiZExsN2xxb2ZiYjdaY01Sd2hWV1B0?=
 =?utf-8?B?SGVQbmhnalBiZVZiV0E1WXhJWEVzRHJVa1U0VHF6VXAzQjhCWmtDZ0lqT3pK?=
 =?utf-8?B?UlUvdGJ4YU5hMnorbTNteXdQb3BIWlgrS0JZMjlnVUZnVDgxVFNzLzZBNWNI?=
 =?utf-8?B?OHYyS0JvTEZCeXlnZkgraDQxK0l6NWFzaldWRUNCNjU4bTJ6ODRMRmtURUE2?=
 =?utf-8?B?TUY4bGF4U2pEWHpSZ2Q0NlVvbnlsUW0xM1VodTFRUDNFY3VlbGZhYVljbjlG?=
 =?utf-8?B?cU1aTW5CMVF5ejBVbStaZ1lnaFZsN1B1SDA1cDh2Zm5JYlJUa29XdnRFZzFW?=
 =?utf-8?B?dXVlYSs0b0NzbkRCMytUb1BreW5peVJ6RzVmano4TnI2cWlhWWFwMlo5Mk5Z?=
 =?utf-8?B?Y0NrSzZHenh0QmRmckhNT1Fkd21hektwekZFQ0xlNGNnSjZiSTZiOU1JMmNh?=
 =?utf-8?B?Nm1id2dhejhZN1c3bFlzRkVQYlAvUDZSbE9rY0NuMWVqV1J2TWp0NU4yZkFq?=
 =?utf-8?B?dFdybFNMaUd5R1VjY0JjQ3ZRRXJFcHVPTi8xOTRwWkRxTW5tRzVLSGhoL290?=
 =?utf-8?B?TUZmSndubnY3SnpQS3NGeEVmSTUyY1ZvdmZub3NqZWZPTWg4U052Q2RteERh?=
 =?utf-8?B?QmJiWnl4Y2gzcnpzd1JnMHBTTTFvaTR6SUdaMkZBbnR0MkhZdmdGRi9JWXNR?=
 =?utf-8?B?bFR4V3RhdmlUQllZaDUxRktkL0s2SktSYVV4RkQ2Q1dkaTd6YjhkUmdzeXdL?=
 =?utf-8?B?d045bUlVcnAzb1NGYVpoUmNCczJKbUF3SlBpTWZsQ1d0N21HK0lyOFoxcTV6?=
 =?utf-8?B?U0VxNFRQblZXOXo3aytER3BPRlVwbExQNGw5ZGdrTGVVSDVvbG93YTBaeEt6?=
 =?utf-8?B?OG9YcTJiZzM1TVVNbVJKUFVKYlNYTnNFa0xYSnB3VU9icE9LMExDRFdrNElj?=
 =?utf-8?B?NTQ2dUs4bkdZQnhBSG4zcmNHNDd6c1ZxSXFGaVlkY01kTDhlN1QvSld4T0d5?=
 =?utf-8?B?Vmw1M0Q5ZzQ5d1NrSG9mR1Urd2k3OXV4akd4VVM4QUJOVUFpQ1RiQU1TWjVD?=
 =?utf-8?B?ZFZyTlkvNkViUCt2RktNbnBzSW5rQUxwQ3hxZGJ3bG5HckxhYnZ5T3lJRDZo?=
 =?utf-8?B?bXhhbFVNMXdIbS83SlY2ejFmaG9IL2xjNnpYeHdTeDE0ODJkT3ZUTTdlVlJN?=
 =?utf-8?B?c3VickUzbTZXL0htVG1lRlJqUUFvWEpBZURMQjFQaklDNHM3RFV4UWpIRGRJ?=
 =?utf-8?B?T291SWI0WFEvbmk2VVhNMUVCbHJhY3orQnN6am9XVm40Nit2bUg5NVpTRWRw?=
 =?utf-8?B?Q28xSldkckxQVVp0ZUs0Tkxwam9Pb1RQblk0bzFJSnhaU0FldkR4SDBLdGFT?=
 =?utf-8?B?QitSek9WQngvS3lpdFdadXJQMWVEYTdqVzZkYzUrYzB4a0gzSXNvVDd6M3Fw?=
 =?utf-8?Q?/7fgPcwpOrLMbzu2/lXD2cY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C2143BF9764C742B77451AD7FD2DEB8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30b2917-5718-43b7-5677-08daf4d1572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 19:15:17.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gAvjJkzRqB5Enh9FyfpjQWrf/QNMSTRbz+o0rzAED2vTVJV8roUpnsomN+N+hyTSJYmo8MuV7jHELK2yBj7v9QdCHNuiAg4wPPW029g1h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTEyIGF0IDE1OjE1ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gSSBkb24ndCB0aGluayB0aGUgYWJvdmUgaXMgbmVlZGVkLiAgVGhl
IGNvZGUgdXNpbmcgdGhpcyBmdW5jdGlvbg0KPiA+ID4gY2Fubm90IGJlIHByZWVtcHRlZCBhbnl3
YXkgQUZBSUNTLg0KPiA+IA0KPiA+IFRoZSByZWFzb24gSSB0aG91Z2h0IGl0IHdhcyB1c2VmdWwg
d2FzIGJlY2F1c2UgdGhpcyBmdW5jdGlvbiBpcyBub3cNCj4gPiBkZWZpbmVkIGluIGEgaGVhZGVy
LiBTb21lb25lIGVsc2UgbWlnaHQgZGVjaWRlIHRvIHVzZSBpdC4gRG9lcyBpdA0KPiA+IHNlZW0N
Cj4gPiBtb3JlIHVzZWZ1bD8NCj4gDQo+IFdlbGwsIGl0IGlzIGV4cG9zZWQgbm93LCBidXQgb25s
eSBpbiBvcmRlciB0byBhbGxvdyB0aGUgX193ZWFrDQo+IGZ1bmN0aW9uIHRvIGJlIG92ZXJyaWRk
ZW4uICBJIGRvbid0IHRoaW5rIGl0IGlzIGxvZ2ljYWxseSB2YWxpZCB0bw0KPiB1c2UNCj4gaXQg
YW55d2hlcmUgYmV5b25kIGl0cyBvcmlnaW5hbCBjYWxsIHNpdGUuDQo+IA0KPiBUbyBtYWtlIHRo
YXQgY2xlYXIsIEkgd291bGQgY2FsbCBpdCBzb21ldGhpbmcgaGliZXJuYXRpb24tc3BlY2lmaWMs
DQo+IGxpa2UgaGliZXJuYXRlX2NvcHlfdW5tYXBwZWRfcGFnZSgpIGFuZCBJIHdvdWxkIGFkZCBh
IGtlcm5lbGRvYw0KPiBjb21tZW50IHRvIGl0IHRvIGRlc2NyaWJlIGl0cyBpbnRlbmRlZCB1c2Uu
DQoNCk9rLCBJJ2xsIGNoYW5nZSB0aGUgbmFtZSwgdGhhdCBtYWtlcyBzZW5zZS4NCg0KT24gdGhl
IHdhcm5pbmcsIG9rLCBJJ2xsIGRyb3AgaXQuIEJ1dCB0byBtZSB0aGUgY29kZSBzdGFuZCBvdXQg
YXMNCnF1ZXN0aW9uYWJsZSB3aXRoIHRoZSBQVEUgY2hhbmdlIGFuZCBvbmx5IHRoZSBsb2NhbCBU
TEIgZmx1c2guIEl0J3MgYQ0KYml0IG9mIGEgY29tbWVudCBhcyBjb2RlIG9uIGEgcmFyZSBwYXRo
Lg0KDQo+IA0KPiBGdXJ0aGVybW9yZSwgSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBuZXcgY29kZSBs
YXlvdXQuDQo+IA0KPiBQZXJzb25hbGx5LCBJIHdvdWxkIHByZWZlciBoaWJlcm5hdGVfbWFwX3Bh
Z2UoKSBhbmQNCj4gaGliZXJuYXRlX3VubWFwX3BhZ2UoKSB0byBiZSB0dXJuZWQgaW50byBfX3dl
YWsgZnVuY3Rpb25zIGFuZA0KPiBwb3NzaWJseQ0KPiBvdmVycmlkZGVuIGJ5IHRoZSBhcmNoIGNv
ZGUsIHdoaWNoIHdvdWxkIGFsbG93IHRoZSBhbW91bnQgb2YgY2hhbmdlcw0KPiB0byBiZSByZWR1
Y2VkIGFuZCBkb19jb3B5X3BhZ2UoKSB3b3VsZG4ndCBuZWVkIHRvIGJlIG1vdmVkIGludG8gdGhl
DQo+IGhlYWRlciBhbnkgbW9yZS4NCg0KQ3VycmVudGx5IGhpYmVybmF0ZV9tYXBfcGFnZSgpIG1h
cHMgdGhlIHBhZ2Ugb24gdGhlIGRpcmVjdCBtYXAgYW5kDQpkb2Vzbid0IHJldHVybiBhbnl0aGlu
Zy4gVGhpcyBuZXcgY29kZSBlZmZlY3RpdmVseSBjcmVhdGVzIGEgcmVhZGFibGUNCmFsaWFzIGlu
IHRoZSBmaXhtYXAuIFNvIGl0IHdvdWxkIGhhdmUgdG8gcmV0dXJuIGFuIGFkZHJlc3MgdG8gdXNl
IHNvDQp0aGUgY29yZSBoaWJlcm5hdGUgY29kZSB3b3VsZCBrbm93IHdoZXJlIHRvIGNvcHkgZnJv
bS4gVGhlbiBpdCB3b3VsZA0KaGF2ZSB0byBwYXNzIGl0IGJhY2sgaW50byBoaWJlcm5hdGVfdW5t
YXBfcGFnZSgpIGZvciB0aGUgYXJjaCB0byBkZWNpZGUNCndoYXQgdG8gZG8gdG8gY2xlYW4gaXQg
dXAuIEkgdGhpbmsgaXQgd291bGQgYmUgbW9yZSBjb21wbGljYXRlZC4NCg0KVGhlcmUgaXMgYWxz
byBhbHJlYWR5IG11bHRpcGxlIHBhdGhzIGluIGhpYmVybmF0ZV9tYXBfcGFnZSgpIHRoYXQgd291
bGQNCmhhdmUgdG8gYmUgZHVwbGljYXRlZCBpbiB0aGUgYXJjaCB2ZXJzaW9ucy4NCg0KU28gSSBz
ZWUgdGhlIGlkZWEsIGJ1dCBJJ20gbm90IHN1cmUgaXQgZW5kcyB1cCBiZXR0ZXIuIENhbiB3ZSBs
ZWF2ZQ0KdGhpcyBvbmU/DQoNClRoYW5rcywNClJpY2sNCg==
