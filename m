Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EBA6F9526
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEGASY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEGASV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:18:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09485BBA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 17:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683418699; x=1714954699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TimKwO4qAoykQIIgGp8nSdvEpllj5MlhzjwBj85IwlA=;
  b=CiA+XD1KJIhLBjm7dWdEm6RODFWMoDrcr0aTggUMaq8vDYWDHUioqWak
   K4CdDlZp4aP09NwuzJqCRGOAtc6fMYa0do+jU1hRgYouZSSmHSB03RbeP
   t+FOs7gmfat7E32V49/rBhzDAwlZGNJSHJXLnww6ou89R5dbpoXip2Atv
   c4NSnPpGGo721phG/p6qa6T/vnL+/D+jCX21dBRsy0xyuzA9BnaSF7zGz
   lCBl54tzfmckiSW+3rjve8UhdVG/BC5CTwxxR3iBJKDrbv4Hs96zN/Prf
   5XLBa2ekgYqDEo3CbunbIfa3p56XpzZhS6IVa3BjrwNG8btt+IvGfH1dw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="333861846"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="333861846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 17:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="944378267"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="944378267"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2023 17:18:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 17:18:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 6 May 2023 17:18:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 6 May 2023 17:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYcGh8wksfjbmxE9E4kNxLos7ZnhHZt1ysQXfiTX0Y/9fr/Am9P44N19nkY9nPh9hM9IO3CaiOGW3NAI+mLyskHtdwmKdaabD2zcT5QXHRCIh3FdsqVqpFyKLgZeT1SVgUYkT/b6zcvSCkYJdzyF3jJBz/TN+h9IhgYQQ2fklJOoe+Cxt/5ko/DVD0Md7+hRUYTG4N98CPrMakFPdr1zztr+VycdF/E+I+F7uJUP+YobwkU8asQwXyXft9FJ13PvbIt7y6ckD1rDeIq5DON9xLtP2k8Vb/VPzETtN4QJCQbqBRc9fQkUnYvQCqXKf9AzZkkR58dG4GsT8sqFPvxWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TimKwO4qAoykQIIgGp8nSdvEpllj5MlhzjwBj85IwlA=;
 b=e3szJPRffNEwYW+yYl/kmJLDMoe2fv6tSkKbU3Nuw1w0L1MhHKlHgwMpFcV0L6ffdZrwg6qkPFwz2Zwq99moTzLJzb0XfNFYTgUTmefeDNq8k1ve5lcLzMLJLrwFTxVCdep2mEJTUE+4htIHLzJSar5/HmbQcHF9M7bgb7t0Kx0RoNoLF+Fz5HcrvGnobtS5id2xwba6ARbn/K73ie1hv8wihqcDNkKbEgYmk0n9YMsA02Q0nmyvH7O9rQl+wFlPdP830HAuIT1sqrxBrYBDec85vILM19UE9uy65nYI4jT3IhQOJF5HagNNftkzopEqJNEdATkZKF4QOpsuN6L1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sun, 7 May
 2023 00:18:15 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6363.029; Sun, 7 May 2023
 00:18:15 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [GIT PULL] x86/shstk for 6.4
Thread-Topic: [GIT PULL] x86/shstk for 6.4
Thread-Index: AQHZdvLFwdOoBiNv3EeiRW4XzF36M69BDVuAgABnQwCAAAPJgIAMPVyAgAAJkYCAAEWaAA==
Date:   Sun, 7 May 2023 00:18:15 +0000
Message-ID: <085834410eb66433c414f2b81589d45edf1eaf3b.camel@intel.com>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
         <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
         <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
         <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
         <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
         <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
In-Reply-To: <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7611:EE_
x-ms-office365-filtering-correlation-id: 3128c5bb-55b1-4ddc-e2bd-08db4e908d56
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f3BLXU+ZzarbaoUPHULuHi6TRxhiZJzwAN8QvlYp+kd0wOUfjA/rM2h4MMOaQPRyOtZyUouNbMg3b7400hw1BkQOd2as7pLrtdZfYSTE3bWXs1mwvzmz8wfbgV05WWAjQe+ldSJflOM30INKY0BCkmWOrHw8yw0tiezRvdpiCKjYaVzJ3Py85SYy0oLlby5hsjHr1Bk3sI5ovMegTgfz4hft7eWkpYDJm7mZPkuBhpfzoNR/xGIdxgwRki4+HCIbTCnK8gMkCizmATgzkbFufwUAk39tt31t4uMFljnyWU4qt5M+9w5Cehth7QUVMHMkpwSiSUrDftaBHDIm3bTqp7Q6R5XORCZRsm3KLCcUY+g+Df6A73367tUja43MrSiysLX2FsHvpsbXml1iwqor15B17+408gqXJISTFVCVwOVPw480FkvOzHcEOvOuvKsExShMvSkvyb7hn6ivXza4o0Ou8Pz2G+VPxjCle3YZnbc44e7HhQ9VArBrMoh76Qb5y455Rg5hSGUbrn5sM9GU/+666vM479f1Dg1KDL/kWKhrCV0wRTWuShPoFajnyCz+JYe6JMfc31htxIpxKZx/UQwUYnSuh6DaFXU1WZZCvc1LNL1+pFLSzU+niRfL0LBS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(86362001)(38070700005)(41300700001)(478600001)(91956017)(76116006)(66946007)(64756008)(4326008)(6636002)(66446008)(66556008)(66476007)(45080400002)(122000001)(54906003)(110136005)(36756003)(2616005)(83380400001)(316002)(2906002)(6486002)(82960400001)(38100700002)(71200400001)(186003)(8676002)(53546011)(8936002)(6512007)(26005)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2lJTlhDUXdrYkFUOExyNGtiYkROekUwZ2srNHN4VjRuYjBrV0xnQTdtZHlK?=
 =?utf-8?B?cHJZY1gyR0l4MVBHSm5MSko3cXdEWklGWUx0K1VoeXNEUW1hYUpVNFlsU1Zo?=
 =?utf-8?B?Z2FQTXh6TGUycmlCVXY5U0VKem4wcTM5SERhUUpUdnZoYlJCUFNSOEg1MkFH?=
 =?utf-8?B?aHlkRFRlOFN2TTBibm1QOE5vVWFLR3k0LzZkZ0pEa3JVdDR3aUU5NzBhN2s4?=
 =?utf-8?B?KzJ0MVFRMy9LYVhqdVpKTkN0aUVuWkFtL3FwUVl3cmZhV2thRllSUFFhQVcv?=
 =?utf-8?B?V2t4eUlwTlJ4NzRPRlRKUy9zVnR1K0VkTldlUWpUL3RJRk9HSUpVRHZYNjh5?=
 =?utf-8?B?b1JhaUdkTURmVksyMzdLb0Q4V1JoRE8vWjMyVjlVTXJUVUVBYmJ6cDlYT0tw?=
 =?utf-8?B?L2o4QnFyZTl4ZWp2SDhrclFIaUpTZy9zUzlyazVORUpDZG5pYzRTR2lIUGtR?=
 =?utf-8?B?aS9PZlpvUmhGM0xvQzUwOUczcTRCaVZ4azRtMVM1R3o5NHA0dTc4Y1BmWXp5?=
 =?utf-8?B?MG84bFNaK2dveXJOaHZ0U0pORUQwUHZ5SkcrK0tVSnhEQUVPTklwMmNxNjMx?=
 =?utf-8?B?YU9mTDVLc2ZtY1FGUVpOU25sMWNmWEpGWXk2cmFqNm1YNE5LYjhvTkhuNW9m?=
 =?utf-8?B?UXVwbDRidGpGaGZUWHB4enJaOVdtTHdNSXF1M3hIY2lySnZaQXZQZEdvcGZE?=
 =?utf-8?B?SEgvMVNaR3luWnVzN1IwME5CbU1hTjZSWnhkWWpCSDdNNCt0V0kwblNXVFVY?=
 =?utf-8?B?YUJ4RGVNb2ZOcXhhYlhIOTJpc3AwOUpoQ3ZBOHA4QldsTkJMQXJ5ZHFMcTdy?=
 =?utf-8?B?K0VMZzJCY3lQL3dwRnVHMWRUb2JyMGcyT2VPdkc4NXc3citWSjhoVUxRdXds?=
 =?utf-8?B?aFpnc3ZJZWp4TTNIbkZYemlhVWVpaWNaQVpCYnNhTFhIZEtyWVB2L1oySkdW?=
 =?utf-8?B?TFNNTjg1bHRhU01tK2pndmkvdGlHbkRxT1RNQnU1dnF1YzRFNkQyWkJSckRO?=
 =?utf-8?B?WjE5YndFR2tyNExVeU1vZnZqQTlzY2hXUnBYTmU1dXhRUEEvSnVvaXRqQnI3?=
 =?utf-8?B?LzRuZG9sbkhVNldpaDZXL0ZWcXdkTHAwbzRLckNqK1dyN2RBdkVCNjN1eWRU?=
 =?utf-8?B?emJFbmozOHJTNEd4cWhDclI3UnpFMEVKa0dTQnF1LzZVWlZYYUJJY0NJTGdD?=
 =?utf-8?B?K0pSSlN6M1pjS0JOWDRqclp6bzhaUm1YeTJuRGVxMnQyTTlnTitvS3JaeWdC?=
 =?utf-8?B?TVRZcTlabFArZ1pVbEUxeGhGY2FlNkJ2S0FJN2VqdGY2VHpuRkk4NkZmRnZp?=
 =?utf-8?B?WjJLOFRnMnNFVUMrUldIcGdBL2pEN2lRK1plVUhOekQxZUZSRFJxMmxEdW9D?=
 =?utf-8?B?OHpKNVhCdmVYQ3RtUlA4aHV2b2pKMng1aXA4SzBkbFRCaHBnR3liUlJyRTlW?=
 =?utf-8?B?SDVlTDJaK2hHWUJlVXhOTHdnd0hZclFtOUFiKzFMOGcrdFdXZVZGQjM4cjFK?=
 =?utf-8?B?MFpjMktFcXA4Rmx2ZXFEV0d0OTd3QkRUQmZVU3laQ002MXVOeFVCUkZTZXBz?=
 =?utf-8?B?Sk1vMzVJQkJOV2pacmxDWGNidXlNczdaV1NOcENMWFRJY0hFekhmMjc0aWZv?=
 =?utf-8?B?YWc1QTcrMElUcFArVkpTU09TQjBUTlVabkRIclFsMHY4b3cvcGdTOTQ2NExk?=
 =?utf-8?B?WFhrOUU1NmQzVVI3Y3RIbUo0aFBmNlpNVzlUUERzNVdDWGtHWHlTVkxuU1Zr?=
 =?utf-8?B?cVNuekpWMWZCL1VjMzlGWnNxWlhZYnBZNk8rUnlmbTZZd3ExWG9IMmE3bHJ4?=
 =?utf-8?B?Z0hLbGttZGNEbk9zWVVvbmNwaGt2YWRQVldSaVY4WXBqT1ZNaUVpdytDSEZU?=
 =?utf-8?B?VWQ5Q2d2d0c5Vm1rbEViOGtDMmt3cHp3M0tkTXFlNlpBT2kyUEtVdVlwcTVI?=
 =?utf-8?B?YURhYjdrV1pPeXJJOEdTMXlLcWIwZkJqMGdhenYwUEhoYVZ6Sjh6UzdacE9p?=
 =?utf-8?B?LzRjbWNFWDN5ZmpIay9GVEJtekRIdGJYWUlVWXVBWGIyUTVlb0xtdi9sZkNp?=
 =?utf-8?B?bGF4ZUdhYWpOL2VSYUNuZ3g4b0JRaXVYdGRQNkwweTJUKzd0TVEyV08xM2Iv?=
 =?utf-8?B?eGduVTh5RnV6eUFLVUd2dEI3NTdCdFdMblpXZGhQQXhLQUVHdlMvZ1ZWNG9N?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97BF26210FA9A040BE6A7F64EE06B7F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3128c5bb-55b1-4ddc-e2bd-08db4e908d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 00:18:15.6002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JX5Kp58Aq7De1xVRzwrp+Wie+0jEHWl9fpdjzWBJltKi2oroCjRQN8IoUAKfqRO+XDx6PqhFL2LNjDJlNtUqx51/5fxEFxA6yBVMDvn2I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA1LTA2IGF0IDEzOjA5IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gPiBPbiBTYXQsIE1heSA2LCAyMDIzIGF0IDEyOjM04oCvUE0gTGludXMgVG9ydmFsZHMNCj4g
PiA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+
ID4gQW5kIEknbSBhYm91dCBhIHF1YXJ0ZXIgaW4sIGhhdmVuJ3QgZXZlbiBnb3R0ZW4gdG8gdGhl
IG1lYXQNCj4gPiA+ID4geWV0LCA+ID4gYW5kDQo+ID4gPiA+IEkndmUgYWxyZWFkeSBmb3VuZCBh
IGJ1Zy4NCj4gPiANCj4gPiBPaywgc28gZGVzcGl0ZSB0aGlzIEknbSBnb2luZyBhIGJpdCBmdXJ0
aGVyLCBqdXN0IHRvIGZhbWlsaWFyaXplDQo+ID4gbXlzZWxmIHdpdGggdGhpcyBldmVuIGlmIEkg
Y2FuJ3QgcHVsbCBpdC4NCj4gPiANCj4gPiBBbmQgdGhpcyBpcyBob3JyZW5kb3VzOiBwdGVfd3Jw
cm90ZWN0KCkgZG9pbmcNCj4gPiANCj4gPiDCoMKgwqAgaWYgKHB0ZV9kaXJ0eShwdGUpKQ0KPiA+
IMKgwqDCoMKgwqDCoMKgIHB0ZSA9IHB0ZV9ta3NhdmVkZGlydHkocHRlKTsNCj4gPiANCj4gPiB3
aGljaCBhY3R1YWxseSBoYXMgdHdvIGZ1bmRhbWVudGFsIHByb2JsZW1zOg0KPiA+IA0KPiA+IMKg
KGEpIGl0IHNob3VsZG4ndCBiZSBhIGNvbmRpdGlvbmFsIHRoaW5nIGF0IGFsbCwgaXQgc2hvdWxk
IGp1c3QgYmUNCj4gPiA+IGJpdA0KPiA+IG9wZXJhdGlvbnMNCj4gPiANCj4gPiDCoChiKSAicHRl
X2RpcnR5KCkiIGlzbid0IGV2ZW4gdGhlIHJpZ2h0IHRoaW5nIHRvIHVzZSwgc2luY2UgaXQNCj4g
PiBpbmNsdWRlcyB0aGUgU1cgZGlydHkgYml0Lg0KDQpwdGVfZGlydHkoKSBhY3R1YWxseSBkb2Vz
bid0IGNoZWNrIHRoZSB0aGUgU1cgZGlydHkgYml0LCBidXQgdGhpcw0KcHJvYmFibHkganVzdCBy
ZS1lbmZvcmNlcyB0aGUgb3ZlciBjb21wbGV4aXR5IGhlcmUuDQoNCj4gDQpbIHNuaXAgXQ0KPiA+
IA0KPiA+IE5vdywgbXkgcmVhY3Rpb24gaGVyZSBpcw0KPiA+IA0KPiA+IMKgLSB0aGUgd2hvbGUg
c2hhZG93IHN0YWNrIG5vdGlvbiBvZiAiZGlydHkgYnV0IG5vdCB3cml0YWJsZSBpcyBhID4NCj4g
PiBtYWdpYw0KPiA+IG1hcmtlciIgaXMgKkRJU0dVU1RJTkcqLiBJdCdzIHdyb25nLg0KPiA+IA0K
PiA+IMKgwqAgV2hhdGV2ZXIgSW50ZWwgZGVzaWduZXIgdGhhdCBjYW1lIHVwIHdpdGggdGhhdCAt
IGluc3RlYWQgb2YganVzdA0KPiA+IHBpY2tpbmcgYW5vdGhlciBiaXQgZm9yIHRoZSAqSEFSRFdB
UkUqIHRvIGNoZWNrIC0gc2hvdWxkIGJlDQo+ID4gYXNoYW1lZC4NCj4gPiANCj4gPiDCoMKgIE5v
dyB3ZSBoYXZlIHRvIHBpY2sgYSBzb2Z0d2FyZSBiaXQgaW5zdGVhZCwgYW5kIHBsYXkgZ2FtZXMg
Zm9yDQo+ID4gdGhpcy4gQkFEIEJBRCBCQUQuDQo+ID4gDQo+ID4gwqDCoCBJJ20gYXNzdW1pbmcg
dGhpcyBpcyBzb21ldGhpbmcgd2hlcmUgTWljcm9zb2Z0IHdlbnQgIndlIGFscmVhZHkNCj4gPiBk
b24ndCBoYXZlIHRoYXQsIGFuZCB3ZSB3YW50IGFsbCB0aGUgc3cgYml0cyBmb3Igc3csIHNvIGRv
IHRoaXMiLg0KPiA+IEJ1dA0KPiA+IGZyb20gYSBkZXNpZ24gc3RhbmRwb2ludCBpdCdzIGp1c3Qg
bmFzdHkuDQoNCkkgY2FuJ3QgYXJndWUgYWdhaW5zdCB0aGlzLg0KDQo+ID4gDQo+ID4gwqAtIEJ1
dCBpZiB3ZSBoYXZlIHRvIHBsYXkgdGhvc2UgZ2FtZXMsIGp1c3QgKnBsYXkqIHRoZW0uIERvIGl0
IGFsbA0KPiA+IHVuY29uZGl0aW9uYWxseSwgYW5kIG1ha2UgdGhlIHg4Ni02NCBydWxlcyBiZSB0
aGF0ICJkaXJ0eSBidXQgbm90DQo+ID4gd3JpdGFibGUiIGlzIHNvbWV0aGluZyB3ZSBzaG91bGQg
bmV2ZXIgaGF2ZS4NCj4gPiANCj4gPiDCoMKgIEhhdmluZyB0d28gZGlmZmVyZW50IHJ1bGVzLCBh
bmQgY29uZGl0aW9uYWxzIGZvciB0aGVtLCBpcyBib3RoID4NCj4gPiBtb3JlDQo+ID4gY29tcGxl
eCBmb3IgbWFpbnRhaW5lcnMsICphbmQqIGZvciBjb21waWxlcnMuDQo+ID4gDQo+ID4gU28ganVz
dCBtYWtlIHRoYXQgX1BBR0VfQklUX1NPRlRfRElSVFkgYmUgdW5jb25kaXRpb25hbCwgYW5kIGxl
dCdzDQo+ID4ganVzdCBsaXZlIHdpdGggaXQuIEJ1dCBtYWtlIHRoZSBiaXQgb3BlcmF0aW9ucyBl
ZmZpY2llbnQuDQo+ID4gDQo+ID4gTWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nLCBhbmQgdGhl
IHBlb3BsZSB3aG8gaGF2ZSBiZWVuIHdvcmtpbmcNCj4gPiBvbg0KPiA+IHRoaXMgaGF2ZSBhIHJl
YWxseSBnb29kIHJlYXNvbiBmb3IgdGhpcyBtZXNzLiBCdXQgaXQgcmVhbGx5IGxvb2tzDQo+ID4g
aG9ycmlibGUgdG8gbWUuDQo+ID4gDQo+ID4gU28gbWF5YmUgeW91IGNhbiBleHBsYWluIGluIHNt
YWxsIHdvcmRzIHdoeSBJJ20gd3JvbmcsIGJ1dCByaWdodA0KPiA+IG5vdw0KPiA+IG15IGZlZWxp
bmcgaXMgdGhhdCBub3Qgb25seSBkaWQgSSBmaW5kIGFuIGFybSBidWcgaW4gdGhlIHNlcmllcw0K
PiA+ICh0cml2aWFsbHkgZml4ZWQgd2l0aCBhIG9uZS1saW5lciwgYnV0IHdvcnJ5aW5nLCBhbmQg
dHJpZ2dlcmVkIGJ5DQo+ID4gdGhlDQo+ID4gc2VyaWVzIGJlaW5nIGRvbmUgaW4gYSBwYXJ0aWN1
bGFybHkgZnJhZ2lsZSB3YXkpLg0KPiA+IA0KPiA+IEJ1dCBJIGFsc28gdGhpbmsgdGhlcmUgYXJl
IHNvbWUgeDg2IHRoaW5ncyB0aGF0IGFyZSBqdXN0IG5vdCBkb25lDQo+ID4gdGhlDQo+ID4gd2F5
IHRoZXkgc2hvdWxkIGhhdmUgYmVlbiBkb25lLg0KPiA+IA0KPiA+IEJ1dCBhZ2FpbjogbWF5YmUg
SSBkb24ndCB1bmRlcnN0YW5kIHNvbWUgb2YgdGhlIHByb2JsZW1zLg0KPiA+IA0KDQpSZWZsZWN0
aW5nIG9uIHRoZXNlIHBvaW50cywgSSB0aGluayB0aGVyZSBtaWdodCBoYXZlIGJlZW4gc29tZSBh
bW91bnQNCm9mIHdpc2hmdWwgdGhpbmtpbmcgYXJvdW5kIHdhbnRpbmcgdG8gZHJhdyBsaW5lcyBh
cm91bmQgdGhlIHVnbGluZXNzDQphbmQga2VlcCBpdCBhdCBiYXkuDQoNCkknbSBzd2F5ZWQgYnkg
eW91ciBhcmd1bWVudCB0byBiaXRlIHRoZSBidWxsZXQgZm9yIHRoZSByZWR1Y2VkDQpjb21wbGV4
aXR5IGFuZCBpbmNyZWFzZWQgdGVzdGluZy4gVGhlIG9ubHkgY2F2ZWF0IHRoYXQgSSBjb3VsZCBw
b2ludA0Kb3V0IHdvdWxkIGJlOiB3aXRoIHRoZSBleGlzdGluZyBzb2x1dGlvbiB3ZSByZXRhaW4g
dGhlIGFiaWxpdHkgdG8NCmNvbXBpbGUgb3V0IHNhdmVkLWRpcnR5LiBJdCdzIGEgYml0IHRob3Ju
eSBhbmQgaWYgYW55dGhpbmcgZ29lcyB3cm9uZywNCnRoZSB3aG9sZSB0aGluZyBjYW4gZWFzaWx5
IGJlIGRpc2FibGVkLiBTbyB0aGVyZSBtaWdodCBiZSBhbiBhcmd1bWVudA0KdGhhdCBoYXZpbmcg
dHdvIHNldHMgb2YgbG9naWMgaXMgYSBiZXR0ZXIgdGhpbmcgdG8gc3RhcnQgb3V0IHdpdGgsIGV2
ZW4NCmlmIHRoZSBsb25nIHRlcm0gc29sdXRpb24gaXMgc2F2ZWQtZGlydHkgYWxsLXRoZS10aW1l
Lg0KDQpJIGRvbid0IHdhbnQgdG8gYXJndWUgaXQgdG9vIHN0cm9uZ2x5IHRob3VnaCwgYmVjYXVz
ZSBpdCdzIGNsZWFyIG5vdw0KaG93IHlvdSBjYW4gbG9vayBhdCB0aGlzIGFuZCB0aGluaywgdGhp
cyBjYW4ndCBiZSByaWdodC4gQW5kIGluIGFueQ0KY2FzZSBJIGRpZG4ndCBqdXN0aWZ5IGhhdmlu
ZyB0aGUgdHdvIG1vZGVzIGluIGFueSBvZiB0aGUgbG9ncy4NCg0K
