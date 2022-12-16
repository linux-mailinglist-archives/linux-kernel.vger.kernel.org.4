Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0BA64F44A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLPWzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLPWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:55:35 -0500
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4C61D50
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1671231276;
        bh=7bVgmZChliTvwSwfBxnI3U/uct5kJwc1JUGp4KNH7l0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Hu7XCLYXmgiFaAyxzUK3LOm0snI1kaSlfipDEYLGvOuPULgtiPW23hffTCMahCcN5
         xR5z2CnaarfDIiBEppDJSHpJTD8yMzuq/Es8eXQ7QaNuw890/Bs3WuvFd3ndfVshNP
         t36DSapzxBcjhQRCH49DF1teYUr3NcAoCwDt6NzUABN5CCigj7+DjaBmTZxFoFsrCl
         Z3G+FwzObuxuotV5QDDwv3CtBanRrfd54zaAccIQaGvm1UewzKoJ5Tb8sT2/bdJMws
         k+wWLORY8qPOXkG67vtlxtl3WoCnjNXWsfLbJv7wm6XzxssaCpnQG6Wr+wCNeg4oV8
         6sG7kFAgjqWfQ==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: No matching files for file entry added in MAINTAINERS
Thread-Topic: No matching files for file entry added in MAINTAINERS
Thread-Index: AQHZETV3L48iYdVPikW6g2xOmHUlRa5xHofA
Date:   Fri, 16 Dec 2022 22:54:33 +0000
Message-ID: <df35a27cca8444b884e35b1b9387beb2@dh-electronics.com>
References: <CAKXUXMxpWOXCUY-dd02P4ckAhF211VJtPTFeTriCMozZon7A5w@mail.gmail.com>
In-Reply-To: <CAKXUXMxpWOXCUY-dd02P4ckAhF211VJtPTFeTriCMozZon7A5w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVrYXMgQnVsd2FobiBbbWFpbHRvOmx1a2FzLmJ1bHdhaG5AZ21haWwuY29tXQ0KU2Vu
dDogRnJpZGF5LCBEZWNlbWJlciAxNiwgMjAyMiAxMTowMiBBTQ0KPiANCj4gRGVhciBDaHJpc3Rv
cGgsDQo+IA0KPiB3aXRoIGNvbW1pdCA4OTQ3OTllMWY0OTYgKCJNQUlOVEFJTkVSUzogQWRkIERI
Q09SIHRvIHRoZSBESCBlbGVjdHJvbmljDQo+IGkuTVg2IGJvYXJkIHN1cHBvcnQiKSwgb3JpZ2lu
YXRpbmcgZnJvbQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIxMTE3MTA1MTMx
LjcwNTktMS1jbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tLywNCj4geW91IGhhdmUgYWRk
ZWQgYSBmaWxlIGVudHJ5IHRvIERIIEVMRUNUUk9OSUNTIElNWDYgREhDT00vREhDT1IgQk9BUkQN
Cj4gU1VQUE9SVCwgYnV0IHRoZXJlIGlzIG5vIGZpbGUgbWF0Y2hpbmcgdGhpcyBlbnRyeSBpbiB0
aGUgcmVwb3NpdG9yeS4NCj4gDQo+IEFyZSB0aGVyZSBzdGlsbCBmaWxlcyB0byBjb21lIG9yIHNo
b3VsZCB0aGlzIHBhdHRlcm4gYWN0dWFsbHkgbWF0Y2gNCj4gY2VydGFpbiBmaWxlcyBpbiB0aGUg
cmVwb3NpdG9yeSwgYnV0IHRoZXkgYXJlIG5hbWVkIHNsaWdodGx5DQo+IGRpZmZlcmVudD8NCj4g
DQo+IA0KDQpBdCBsZWFzdCBvbmUgREhDT1IgZmlsZSBzaG91bGQgY29tZSBzb29uIGhvcGVmdWxs
eToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMjAyMjExMjMxNzM2
MDEuMTMyOTEtMi1jbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tLw0KDQoNCkJlc3QgcmVn
YXJkcw0KQ2hyaXN0b3BoDQo=
