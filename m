Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2472E2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbjFMMZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbjFMMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:25:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D710CB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:25:14 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-Ufe39FLKM9uv02YWJ1c2EA-1; Tue, 13 Jun 2023 13:25:11 +0100
X-MC-Unique: Ufe39FLKM9uv02YWJ1c2EA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Jun
 2023 13:25:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 13 Jun 2023 13:25:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Kasireddy, Vivek'" <vivek.kasireddy@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Hugh Dickins <hughd@google.com>
CC:     Gerd Hoffmann <kraxel@redhat.com>,
        "Kim, Dongwon" <dongwon.kim@intel.com>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "jmarchan@redhat.com" <jmarchan@redhat.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        James Houghton <jthoughton@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
Thread-Topic: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
Thread-Index: AQHZmkrTMFwnMH2R1EGnnRur83Hw9a+FyCfggAEHOQCAAT7FoIAAoNDA
Date:   Tue, 13 Jun 2023 12:25:03 +0000
Message-ID: <89652021ecea4aa2ada763c97deeb543@AcuMS.aculab.com>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
 <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
 <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2FzaXJlZGR5LCBWaXZlayA8dml2ZWsua2FzaXJlZGR5QGludGVsLmNvbT4NCj4gU2Vu
dDogMTMgSnVuZSAyMDIzIDA5OjI2DQouLi4NCj4gPiBJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJl
Y3QsIHRoYXQgd2UgY2FuIGVmZmVjdGl2ZWx5IGxvbmctdGVybSBwaW4NCj4gPiAod29yc2UgdGhh
biBtbG9jaykgNjQgTWlCIHBlciBVRE1BQlVGX0NSRUFURSwgYWxsb3dpbmcgZXZlbnR1YWxseSAh
cm9vdA0KPiA+IHVzZXJzDQo+DQo+IFRoZSA2NCBNaUIgbGltaXQgaXMgdGhlIHRoZW9yZXRpY2Fs
IHVwcGVyIGJvdW5kIHRoYXQgd2UgaGF2ZSBub3Qgc2VlbiBoaXQgaW4NCj4gcHJhY3RpY2UuIFR5
cGljYWxseSwgZm9yIGEgMTkyMHgxMDgwIHJlc29sdXRpb24gKGNvbW1vbmx5IHVzZWQgaW4gR3Vl
c3RzKSwNCj4gdGhlIHNpemUgb2YgdGhlIEZCIGlzIH44IE1CICgxOTIweDEwODB4NCkuIEFuZCwg
bW9zdCBtb2Rlcm4gR3JhcGhpY3MNCj4gY29tcG9zaXRvcnMgZmxpcCBiZXR3ZWVuIHR3byBGQnMu
DQoNCldoYXQgY29kZSBkb2VzIGFuZCB3aGF0IHBvdGVudGlhbGx5IG1hbGljaW91cyBjb2RlIG1p
Z2h0IGRvDQphcmUgZW50aXJlbHkgZGlmZmVyZW50IHRoaW5ncy4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

