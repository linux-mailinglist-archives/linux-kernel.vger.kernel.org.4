Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEF74274E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjF2NYR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 09:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjF2NYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:24:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E41E30DF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:24:14 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-54-8rh9MoxjMk2CwbwNRMsZVQ-1; Thu, 29 Jun 2023 14:23:55 +0100
X-MC-Unique: 8rh9MoxjMk2CwbwNRMsZVQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 14:23:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 14:23:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Samuel Thibault' <samuel.thibault@ens-lyon.org>,
        Kees Cook <keescook@chromium.org>
CC:     Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Dave@mielke.cc" <Dave@mielke.cc>
Subject: RE: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Thread-Topic: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Thread-Index: AQHZqZu1MI//nXKQnEKNH07rOK4tp6+hxWvQ
Date:   Thu, 29 Jun 2023 13:23:54 +0000
Message-ID: <55c209a024a94d1f9c6af85dfddb11a0@AcuMS.aculab.com>
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin> <202306271944.E80E1D0@keescook>
 <20230628060716.vvgtlgbushyjh6km@begin>
In-Reply-To: <20230628060716.vvgtlgbushyjh6km@begin>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Thibault
> Sent: 28 June 2023 07:07
...
> > So is there really no solution for brltty and TIOCSTI being disabled?
> 
> No, there is no way to simulate characters on the Linux console. The
> alternative would be to use uinput, but that simulates keycodes, not
> characters, thus requiring backtranslating first, which is very fragile.

It could probably be rewritten to use a pseudo-tty pair.
It might even be possible to emulate (the functionality of) TIOCSTI
in the relay process that handles the pseudo-tty.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

