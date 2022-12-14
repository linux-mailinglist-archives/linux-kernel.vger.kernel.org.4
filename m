Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3164C7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbiLNLFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Dec 2022 06:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbiLNLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:05:19 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512721031
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:05:16 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-242-JdesrG8NMdGniNtm-PNc3Q-1; Wed, 14 Dec 2022 11:05:13 +0000
X-MC-Unique: JdesrG8NMdGniNtm-PNc3Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 14 Dec
 2022 11:05:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Wed, 14 Dec 2022 11:05:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nicolas Schier' <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH] kbuild: ensure Make >= 3.82 is used
Thread-Topic: [PATCH] kbuild: ensure Make >= 3.82 is used
Thread-Index: AQHZDqgK2HakTLHXy0uTd8KCKGQlc65tOHlQ
Date:   Wed, 14 Dec 2022 11:05:10 +0000
Message-ID: <6c4413040a624b728081e27213fb46a1@AcuMS.aculab.com>
References: <20221211030352.2622425-1-masahiroy@kernel.org>
 <Y5djBr9rVhSq8+iK@dev-arch.thelio-3990X> <Y5f4ZgyK7QlqYu31@bergen.fjasle.eu>
In-Reply-To: <Y5f4ZgyK7QlqYu31@bergen.fjasle.eu>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Schier
> Sent: 13 December 2022 03:59
...
> > > diff --git a/Makefile b/Makefile
> > > index 2dda1e9a717a..66dfc5751470 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -11,6 +11,11 @@ NAME = Hurr durr I'ma ninja sloth
> > >  # Comments in this file are targeted only to the developer, do not
> > >  # expect to learn how to build the kernel reading this file.
> > >
> > > +# Ensure Make >= 3.82

Wouldn't it be better to say either:
	# Ensure gmake supports 'undefine' (added in 3.82)
or:
	# Building with gmake versions prior to 3.82 fails due to
	# bug 'brief description'.
	# Check for 'undefine' support as a surrogate for the bug fix.

    David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

