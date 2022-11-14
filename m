Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F24627A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiKNKbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiKNKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:30:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE81CFF9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:30:33 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-157-tllJCD2ZOviJ5raebD2L6w-1; Mon, 14 Nov 2022 10:30:31 +0000
X-MC-Unique: tllJCD2ZOviJ5raebD2L6w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Nov
 2022 10:30:30 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Mon, 14 Nov 2022 10:30:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steffen Kothe' <steffen.kothe@skothe.de>,
        Saravana Kannan <saravanak@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scripts: dev-needs.sh: Enforce bash usage
Thread-Topic: [PATCH] scripts: dev-needs.sh: Enforce bash usage
Thread-Index: AQHY9nrzV6h2kOtPfk+QcQVuvk82U64+NnnQ
Date:   Mon, 14 Nov 2022 10:30:29 +0000
Message-ID: <cff9a58b31e3493fb1231db54705bb30@AcuMS.aculab.com>
References: <20221109170341.36785-1-steffen.kothe@skothe.de>
 <CAGETcx9fx3TcgeD+pMyp+LuGfd=hOo5_Weeii2W1Mbd1T2Ua0Q@mail.gmail.com>
 <Y205W3kavB5tIDK3@p50>
 <CAGETcx9Z2_Oc-L8Y0x+zuPUEgeaDSnFSFUSU+nxcF5Rxtf6FvQ@mail.gmail.com>
 <Y29qN1fFq4SFXCT2@p50>
In-Reply-To: <Y29qN1fFq4SFXCT2@p50>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmZlbiBLb3RoZQ0KPiBTZW50OiAxMiBOb3ZlbWJlciAyMDIyIDA5OjQxDQouLi4N
Cj4gV2hhdCBhYm91dCBhIHJlLXdyaXRlIG9mIHRoZSBzY3JpcHQgaW4gUE9TSVggY29tcGxpYW50
IHN0eWxlPyBUaGlzDQo+IHNob3VsZCB3b3JrIHRoZW4gaW4gZXZlcnkgc2hlbGwgZGVyaXZhdGUg
d2l0aG91dCB3ZWlyZCBjaGVja3MuDQo+IA0KPiBUaGlzIHdvdWxkIHJlbW92ZSBmb3IgZXhhbXBs
ZSBmdW5jdGlvbiBkZWNsYXJhdGlvbnMsIGFycmF5cyBhbmQgc28gb24sDQo+IHRhcmdldGluZyB0
byB0aGUgc2FtZSBwcmludGFibGUgb3V0cHV0IGJ1dCB3aXRoIGRpZmZlcmVudCBsb2dpYyBpbiB0
aGUNCj4gYmFja2dyb3VuZC4NCg0KQSBxdWljayByZWFkOg0KDQotIHJlbW92ZSB0aGUgd29yZCAn
ZnVuY3Rpb24nLg0KLSByZW1vdmUgYWxsICdsb2NhbCcsIGVuc3VyZSBuYW1lcyBhcmUgdW5pcXVl
Lg0KLSB1c2UgJ3ByaW50ZiAnJXMnICIuLi4uLiIgaW5zdGVhZCBvZiBlY2hvIC1uLg0KDQpUaGF0
IHNob3VsZCBiZSBwcmV0dHkgbmVhciBwb3J0YWJsZS4NClNvbWUgc2hlbGxzIHRoYXQgZG9uJ3Qg
b2JqZWN0IHRvIHRoZSAnbG9jYWwnIGtleXdvcmQgZG9uJ3QNCmFjdHVhbGx5IGltcGxlbWVudCBs
b2NhbCB2YXJpYWJsZXMhDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

