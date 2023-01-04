Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C92E65CEC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjADIwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjADIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:51:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC11E3FB;
        Wed,  4 Jan 2023 00:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672822213; x=1704358213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KqJSzy5iL11h1E1JVErqP1MCBNpk+1IE+z7GIqEUtJk=;
  b=GfWH5n8sibOE9duk0BtB8iwSp2Onj7Gjmm3o4bbn+03qAWJJCc+Aj07g
   iuqOz3kJ9puUF3efC4tOldIc2QkHyUi/IWwbaSiY0Aj1NeWwQohS/9BoR
   G/lROdQ9787o/1AgHhwEayFSLwAqQ9r/MGeQrlSP4BH1UdiR5Hg4o1/Wh
   VxKVRo58ryfE/2S7N4R3/HeMZKszIOC3RtNfyIdUu9gBAvEa4yn8u6Oix
   TIwwm5msBHsNQqorhScVsNyXw3clJfdJAJ+LrYBHVNrfOvOfDUjMlPcVD
   2J4Rz4XVIh1MeaRqeQ7FQWgOhNwpph2+RcHVVFyAZ5XkdAIbqT9wPqt7M
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323121853"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="323121853"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 00:50:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797459091"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797459091"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 00:50:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 00:50:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 00:50:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 00:50:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leHx4yGw90khXL6lVvBsLmxoGfd4PpheMtJbnDM65vjbcAHByBatIrrlLj0ygDEQdPOGeEbwBrgNV8DPBlK58++G31T1hcB+yV0ZqQtS9RicCDLI8aW11SGgyJLB+jCRX/5xDy6Yzsc6RkgaGXI4ZFawsI5QXODYeClJlvcsbi9Qr6UrzayfQGF3tHYk6Suce8g0hIXdVGAMhlMk18ihAb35Yn3dZLobs937/3EYfvNRi+xHDCtD2lCdqQMal1emzGnkrbj9GyabyRnyKmx1qlP95WFFicwfeScc4SgcI2Y9mmUFIC0Ybp8rZ4LLQPoyQ14RqYPXweLqZsXUXtIusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqJSzy5iL11h1E1JVErqP1MCBNpk+1IE+z7GIqEUtJk=;
 b=NcNGxzSuXj6k/WNje58s6jkX792znVtg4OzqUTr7aaFLHcrSt5sDYJnhr67vzI/WMMPHOXDIfCkgYHDrhbRYzZ47S7cCxp4df9x0W448LFozfxCkKLAq7OW76xL2CWVYKfNIWZpmIYa1ki+kCLbcSvPH9t5knpjXguTsyYXy0wXKSdNlFe+xzH/mD4/M/8pEUoBTPqsY1+HwrJHcniftUGEQ0vLMaJ9UcMFV6OfATNVRSIzBBFEcmtnyzewVZSodD8wbbrd1DXylksy4nfKI0kfAxCdqa/aVegtOvKCQqvoPA1f3THwb8iH+EU8Md3+cKeLgK0W0BKEXfl6Oaqrx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:50:10 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5546:ea97:1beb:cb5f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5546:ea97:1beb:cb5f%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:50:10 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "chiluk@ubuntu.com" <chiluk@ubuntu.com>
CC:     "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Thread-Topic: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Thread-Index: AQHZH5oWPk7vfFm5q0SuLPXUasNaNK6N8+WA
Date:   Wed, 4 Jan 2023 08:50:10 +0000
Message-ID: <d8e69f9c91efc5d2529082a7dcee3fedef3211db.camel@intel.com>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
         <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
         <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com>
In-Reply-To: <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3207:EE_|PH0PR11MB7522:EE_
x-ms-office365-filtering-correlation-id: 5f0e8494-2175-4104-5b02-08daee30afc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPiL+C821WJkNPn6XE7LoOevXY5Y94qQUJtqD91j7rEBN6w5UR9uLB8BJQIrXOI72/5nMi5Kp7Rkzco31OgY89VkObGnS8LomhP2xvpcZYNAIj+8IbylLFVcJCeB+VBskiGtY+7WTRKugriDSMeMUxiMwM7sxc6XPYxxMF2+vK6aIH4qEQS0vwAKLzDLb3lKq3sj/2o/NWh9fLJl7hLjKJ69JkcwgnF/n7hMcrXZeZffOl/g+EN/5PXDWHVXecWbljCvrUxS59oH0ya6yuV6F0Sra0PyBCZqGjCGDl7z9yJigYFSWzsoYGexb2P+GbVDIStqoJfs3JUpFatquWWyTy4UdYfaBgu4Dh3djNVjivyRgdlL0g96GQRew1BeSmmlvG7qJQ/3P2p+Ibd7ba+7+TGU7mlAT2S7G+K7iXywHxv+wvKaJiQKpRBHucwIrOnoUXbefQEQn8ildkuA7l7/Lbc9dUzFpKXzwjyn1FgD5LgnFzWU5l4h2HN17PqzgmEXpiOou8f0DzhUHenHTHrVGGysTWaUmHtpd0xucME/GxVBcZp9Lo/A56hZ5GsgpMbfX8vYe9T6aikh0CYoa9t8q+1yP1iFnCXoTMIUU/Qw4lB/M8TDbr9wRohft87FSra7GCJy87mPlB4XvIg6V8ICXydVxut/Dqo/Sec3L6ECfw+DJYSO15pa9EvaIjwAnfdzc47hfENLhD2fEV4cXaY3mfR2cvJdazuz7tZo6Qc5z4c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(186003)(6512007)(83380400001)(26005)(2616005)(86362001)(36756003)(122000001)(38100700002)(82960400001)(38070700005)(54906003)(6916009)(2906002)(316002)(4326008)(66946007)(91956017)(41300700001)(8936002)(5660300002)(8676002)(66446008)(66476007)(76116006)(478600001)(64756008)(71200400001)(66556008)(6486002)(53546011)(6506007)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MElsbzlqL1kva1ZIdTUxSnN2MFFMS0NQdEFXZW9FVUtDZjc2a1pwL1daVTIr?=
 =?utf-8?B?RGtZTlhWWEpUVjBRblRkKzViQm9lcjV1bXNKVFIzdmo4VC9HZmkyYjNFOEIy?=
 =?utf-8?B?OXdzSmZ4UFNoTjFsczRkUjdjeG96WGUrRHE1M2tQbXc3VWpIYkJpSGVmYS9p?=
 =?utf-8?B?SDAraUltUHRvZTFvaVBRV0JPRis3ajlFdjBFMzJVQnNJWGVuYkg3UU55L1g0?=
 =?utf-8?B?TEtMaHFVQUhiWlBCeU9COTdwTzBzbVFyc2JGekhXbStzd3NBcFF5ampHeHpM?=
 =?utf-8?B?bVZxdzVVNUY1MVdoazB4SHNaWVUzNlJpaGFZL1c3Zk8rZUxneGRvZEF1UmJk?=
 =?utf-8?B?NmloMVR0N2VCNnMxVUlwaEU2SUJINmZhRCtXWE11OVJHV2tpZlNRc3BaN3E4?=
 =?utf-8?B?VWxjSk5qeUR4NDRMQm1xZlRqVHRaVFhDeXpoRGt3TFpsZWhrNUZ0bUgzTGVS?=
 =?utf-8?B?ZmswNFRwdTI5UHJDRnpDL2NTcnJHOUFhVHk4SWowRG5FZWxXZHlxWFF2OGhy?=
 =?utf-8?B?ZC9POUdvSWJWVmN4T2dMME83MzI5enhwNXZ3UzBYM1doNjl5M3RvZ1ByeGlG?=
 =?utf-8?B?dWhZTE9aOUFxaFZ2VFc4NFR3bEFXMFpETG5hVjlSRmtiUTZtMFF5ajRKeGdo?=
 =?utf-8?B?Mmc1Z0p1VXBiT3RDNFg3UTc5VmE3bzV5aERaNDZlY21DdW5JZGVQOXNYaEhN?=
 =?utf-8?B?MWFBNndZTTQwcHhVV2xaNHNIN1IzaklaeWRVdmtXbkRacjVOL0luRlNxMmFR?=
 =?utf-8?B?Rlh3KzRMUWVPekVSVnpNSjRReTBPWndWdEkyRHJramJIN2VVMVAzRkZ4VzdQ?=
 =?utf-8?B?aXFJZHNoelp2dFl6b1l3ZXlFV0IxVjJkRmpNcmZSSEJKaDBOTVBOajVEOXF2?=
 =?utf-8?B?OENzdzV4alBWUUczRVhFZ3JPVml6V2VDdGFUTTQ4cko3L1paSjRZUHVhVU9l?=
 =?utf-8?B?SjlDU3IwakcyakNPck1FS2hjRnBwNzV5WXJSTGFwSHFIRkJjK1ZBdzFJWUt3?=
 =?utf-8?B?TzBiR3NieTlWS0tCK05oTGJxRWhGNW53elpzNWIvOVZmbkdTbml3ZmlIaFRQ?=
 =?utf-8?B?blB6Y0FGbUxvbmM5Vk9kMzVFdTBKV2pyekF5aklpQkRzSzZhd3JFL21DL3lI?=
 =?utf-8?B?N2EvQUlqYmhnZThBSTJHSk9TUHRPNUEwRUpOc2FITVlrdmx0Sk11czIvdGg0?=
 =?utf-8?B?V3JqWGlQRTVsSm5aMjJmL1ZnaU4yS2hOcDFDQVUzQSt6UTJNTHBZaDRxQmsy?=
 =?utf-8?B?QWczUDJvQVRBNGFtWHdYT05VZWlXOHdyTWpING1DSFlEUERFWHk0WHE3YXZz?=
 =?utf-8?B?YUpLcyt5M1RrcGFQWHdrVFFScWk3N1djNVFNZElzUVVLN04zNGpXMjYxejhI?=
 =?utf-8?B?YVFuNUdLWGJsNXdiSm5LU2ZuQjFIQWhxcllKbHJuWXlJTVhjZ0o1bDVvU1gx?=
 =?utf-8?B?aTBkYlh3ZDkrN0NBQ0lrSDF6V1VqaUU1Z3RZZ3dySmV0bHhXRHRHcEo4bUQr?=
 =?utf-8?B?d2M4S3VCMWlmVDQzbmxybFloZnZLYmpPb05MOWh0Tng2R0d0aUhXSXovelpa?=
 =?utf-8?B?cWJVUlUrSGJvWXFMaG1RdW5TK00rZXl5S2ZGVVgreDVDOGlOZm5vajNVZTl0?=
 =?utf-8?B?a0ZRUmdVeHY2U1FsZ2xWVEk4ZjdXSU8wQ0FwTDhiYmJoYjBWUFVLSVNIMXho?=
 =?utf-8?B?SWhmN3QycTB4NjUrTEk5RkNpTTJwaXhGYWpMYk5YQ1BtUEh1a2ZWUlF0aXJv?=
 =?utf-8?B?ZHFDSmJQU21EZElveXFYYWFRM1grT1Rta2hCTTN0ZkVkUjFHWUJXbmlVUGN3?=
 =?utf-8?B?V29pZStmbTZaY3dibjBDVGg0OHNBTHdWZC81RktDcnVrS3ZxMzhRT2FFRk9n?=
 =?utf-8?B?WDRmdDcvWkVxbGhEN0JzNU1MQVV4K2xVZDFVOUJxWDIxYXk1U3JrNCt4dzNF?=
 =?utf-8?B?K094QTVOTUM3YTFVN2tmZTJyUHl5MGl4Y1ZOdnF0L2Q3cy9sZ2kwT0xURER2?=
 =?utf-8?B?UU04YjRzcU9RN2M5OU9sbmx1L2hsZTErL043Nm9DTmVwbUV6QndwdVgzaE1F?=
 =?utf-8?B?cnZWcXQ3dkxJUGdBczc5RFozR2tESmtrRGZOcVZnSXFPWnczUWQ3N0RIbnVJ?=
 =?utf-8?B?aFVUMDZkR3kxWnIycTUvVVNZODY4bmFOUjE0NmZUSit6VjZiNzl4bU5yZytE?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56C508E28DB47D45BEFBC2E57E114EDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0e8494-2175-4104-5b02-08daee30afc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 08:50:10.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0/oUFfuKNbBhTujPkQ/4kso0eBTYStK6pBXL0pcM3ocDdXgDuKNbgZUPJGI1MqnpRmHBQwiULUOy+7WgFkVf6SYuIjhoKMPpH4nHWTpBMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
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

T24gVHVlLCAyMDIzLTAxLTAzIGF0IDExOjM3IC0wNjAwLCBEYXZlIENoaWx1ayB3cm90ZToNCj4g
T24gVGh1LCBEZWMgMSwgMjAyMiBhdCA1OjMzIEFNIENvZWxobywgTHVjaWFubyA8bHVjaWFuby5j
b2VsaG9AaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjItMTItMDEgYXQg
MTE6MTQgKzAxMDAsIFRob3JzdGVuIExlZW1odWlzIHdyb3RlOg0KPiA+ID4gSGksIHRoaXMgaXMg
eW91ciBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2VyLg0KPiA+ID4gDQo+ID4gPiBMdWNh
LCBJIG5vdGljZWQgYSByZWdyZXNzaW9uIHJlcG9ydCBpbiBidWd6aWxsYSB3aGVyZSBJJ2QgbGlr
ZSB5b3VyDQo+ID4gPiBhZHZpY2Ugb24uIFRvIHF1b3RlIGh0dHBzOi8vYnVnemlsbGEua2VybmVs
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE2NzUzDQo+ID4gDQo+ID4gSGkgVGhvcnN0ZW4gd2Vhcmlu
Zy10aGUtcmVncmVzc2lvbi1oYXQsIPCfmYINCj4gPiANCj4gPiBJJ20gbm90IHRoZSBtYWludGFp
bmVyIG9mIGl3bHdpZmkgYW55bW9yZSwgc28gSSdtIGFkZGluZyB0aGUgbmV3DQo+ID4gbWFpbnRh
aW5lciBoZXJlLCBHcmVnb3J5IEdyZWVubWFuLg0KPiA+IA0KPiA+IEdyZWdvcnksIGNhbiB5b3Ug
dGFrZSBhIGxvb2s/DQo+ID4gDQo+IA0KPiBAR3JlZ29yeSBHcmVlbm1hbiBhcyBJJ20gc3VyZSB0
aGlzIGdvdCBidXJpZWQgb3ZlciB0aGUgaG9saWRheXMsIGNhbg0KPiB5b3UgdGFrZSBhIGxvb2sg
YXQgdGhpcyBhbmQgYWR2aXNlPyAgVGhpcyBpcyBkZWZpbml0ZWx5IGEgcmVncmVzc2lvbiwNCj4g
YnV0IEkgZG9uJ3QgdGhpbmsgYSBsb3Qgb2YgcGVvcGxlIGFyZSBub3RpY2luZyBpdCBvciBkb24n
dCB5ZXQgaGF2ZQ0KPiA2Z2h6IGFjY2VzcyBwb2ludHMuICBJIGNhbiB3cml0ZSB1cCBhIHBhdGNo
IHJlbW92aW5nIHRoZSBvZmZlbmRpbmcNCj4gY29tbWl0ICg2OThiMTY2ZWQpLCBvciBJIGNhbiBh
ZGQgYW4gaXdsd2lmaSBvcHRpb24gdG8gaWdub3JlIHRoZSA2ZQ0KPiBBQ1BJIGJpdC4gIFdoaWNo
IHdvdWxkIHlvdSBwcmVmZXI/DQo+IA0KPiBEZWxsIGhhcyBiZWVuIG9mIGxpdHRsZSBoZWxwIHdo
aWNoIEkgcHJldHR5IG11Y2ggZXhwZWN0ZWQuDQo+IA0KPiBATHVjaWFubywgYXMgeW91IHdlcmUg
dGhlIGF1dGhvciBvZiB0aGUgb3JpZ2luYWwgY2hhbmdlLCBhbmQgSSdtIG5vdA0KPiBmYW1pbGlh
ciBlbm91Z2ggd2l0aCBBQ1BJLCBpcyB0aGUgYmVsb3cgY29kZSByZWFkaW5nIHRoZSBlbmFibGUg
Yml0cw0KPiBmcm9tIHRoZSBCSU9TIEFDUEkgdGFibGUgb3IgaXMgdGhpcyBzb21laG93IGNvbWlu
ZyBvdXQgb2YgdGhlIG5ldHdvcmsNCj4gY2FyZCB0aHJvdWdoIHNvbWUgVUVGSSBleHRlbnNpb25z
PyAgSSdtIHRyeWluZyB0byBmaWd1cmUgb3V0IHdoaWNoIG9mDQo+IERlbGwgb3IgSW50ZWwgbmVl
ZCB0byB1cGRhdGUgdGhlaXIgZmlybXdhcmU/ICBJIHRoaW5rIHNvbWUgTGVub3ZvJ3MNCj4gaGF2
ZSBzaW1pbGFyIHByb2JsZW1zLCBzbyBJIHN1c3BlY3QgaXQncyBhIEJJT1MgQUNQSSB0YWJsZSBw
cm9ibGVtLg0KPiANCj4gIHJldCA9IGl3bF9hY3BpX2dldF9kc21fdTMyKG12bS0+ZndydC5kZXYs
IDAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRFNNX0ZVTkNfRU5BQkxF
XzZFLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZpd2xfZ3VpZCwgJnZh
bHVlKTsNCg0KRGF2ZSwgdGhpcyBjb2RlIHdhcyBhZGRlZCB0aGVyZSBmb3IgYSByZWFzb24uICBC
dXQgYXMgSSBzYWlkLCBJJ20gbm90DQp3b3JraW5nIHdpdGggV2lGaSBhbnltb3JlLCBzbyBJIHJh
aXNlZCB0aGUgcXVlc3Rpb24gaW50ZXJuYWxseSBhbmQNCkdyZWdvcnkgb3Igc29tZW9uZSBlbHNl
IHdpbGwgcmVzcG9uZCB0byB5b3Ugd2l0aCB0aGUgZGV0YWlscyBzb29uLg0KDQotLQ0KQ2hlZXJz
LA0KTHVjYS4NCg==
