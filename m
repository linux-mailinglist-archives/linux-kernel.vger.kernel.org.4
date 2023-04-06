Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863F76D9891
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjDFNtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbjDFNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:49:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12924E71
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:48:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-204-wxH6a6H_OAKhuIlGVx7W3g-1; Thu, 06 Apr 2023 14:48:56 +0100
X-MC-Unique: wxH6a6H_OAKhuIlGVx7W3g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 6 Apr
 2023 14:48:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 6 Apr 2023 14:48:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Luis Chamberlain' <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "petr.pavlu@suse.com" <petr.pavlu@suse.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Thread-Topic: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Thread-Index: AQHZZ98c6jprfqRD8kOXCEPd17f6W68d7ShggABMYICAABNroA==
Date:   Thu, 6 Apr 2023 13:48:54 +0000
Message-ID: <6ba49055a1a343e8b50f808f91438e39@AcuMS.aculab.com>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
 <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
 <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
 <ZC2nbiarELlUVcSj@bombadil.infradead.org>
 <979c8cf9ab2d4fcba811adc0c563b8bb@AcuMS.aculab.com>
 <48f2c6f2-f776-be29-7d74-67f1b6cf5467@csgroup.eu>
In-Reply-To: <48f2c6f2-f776-be29-7d74-67f1b6cf5467@csgroup.eu>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwNiBBcHJpbCAyMDIzIDE0OjM4DQouLi4N
Cj4gT24gcG93ZXJwYyAnbG9uZyBsb25nJyBpcyA2NCBiaXRzIG9uIGJvdGggUFBDMzIgYW5kIFBQ
QzY0Lg0KDQpJdCBwcm9iYWJseSBpbiBvbiB4ODUtNjQgYXMgd2VsbC4NCkJ5IGJyYWluIGlzIGdl
dHRpbmcgZnJhenpsZWQuDQoNCk9uIDY0Yml0IGxvbmcgbG9uZyBvdWdodCB0byBiZSAxMjhiaXQu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

