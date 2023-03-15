Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6A6BAB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjCOJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjCOJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:00:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C169264220
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:59:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-8KLqB0VTNH6q28Tcl8blTg-1; Wed, 15 Mar 2023 08:59:36 +0000
X-MC-Unique: 8KLqB0VTNH6q28Tcl8blTg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Wed, 15 Mar
 2023 08:59:34 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Wed, 15 Mar 2023 08:59:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'richard clark' <richard.xnu.clark@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: Question about select and poll system call
Thread-Topic: Question about select and poll system call
Thread-Index: AQHZVhzW15NaHXL3bku7XbgbJ/Iq0a77izHg
Date:   Wed, 15 Mar 2023 08:59:34 +0000
Message-ID: <c708bced26624078842ff7d83e8597d7@AcuMS.aculab.com>
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
In-Reply-To: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
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

PiAyLiBDYW4gd2UgdW5pZnkgdGhlIHR3byBkaWZmZXJlbnQgc3lzdGVtIGNhbGxzPyBGb3IgZXhh
bXBsZSwgdXNpbmcNCj4gcG9sbCguLi4pIHRvIGltcGxlbWVudCB0aGUgZnJvbnRlbmQgc2VsZWN0
IGNhbGwoLi4uKSwgaXMgdGhlcmUNCj4gc29tZXRoaW5nIEknbSBtaXNzaW5nIGZvciBjdXJyZW50
IGltcGxlbWVudGF0aW9uPyBUaGUgQ29ucyBhbmQgUHJvcywNCj4gZXRjDQoNClRoZSB1bmRlcmx5
aW5nIGNvZGUgdGhhdCBpbXBsZW1lbnRzIHRoZW0gaXMgY29tbW9uLg0KDQpCZXdhcmUgdGhhdCB0
aGUgZ2xpYmMgc2VsZWN0KCkgd3JhcHBlcnMgaGF2ZSB0aGVpciBvd24gbGltaXQNCm9uIHRoZSBo
aWdoZXN0IGZkLg0KRXhjZWVkaW5nIHRoYXQgbGltaXQgKHByb2JhYmx5IDEwMjQpIHdpbGwgY2F1
c2UgYnVmZmVyIG92ZXJydW5zDQppbiB0aGUgYXBwbGljYXRpb24gKE9uZSBvZiB0aGUgQW5kcm9p
ZCBhcHBzIEkgdXNlcyBjcmFzaGVzIHRoYXQgd2F5KS4NCg0Kc2VsZWN0KCkgYWxzbyBkb2Vzbid0
IHNjYWxlIHdlbGwgZm9yIHNwYXJzZSBsaXN0cyBvZiBmZHMuDQpTbyBpdCByZWFsbHkgaXMgYmVz
dCB0byB1c2UgcG9sbCgpIGFuZCBuZXZlciBzZWxlY3QoKS4NCihBbHRob3VnaCBmb3IgdmVyeSBs
YXJnZSBmZCBsaXN0cyBlcG9sbCgpIG1heSBiZSBhIGJldHRlciBjaG9pY2UuKQ0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

