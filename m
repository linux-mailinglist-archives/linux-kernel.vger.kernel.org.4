Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8C72AF5E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjFJVrK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Jun 2023 17:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFJVrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 17:47:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A0135A3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:47:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-WwJFuWklNRioR6AeYR7C1A-1; Sat, 10 Jun 2023 22:47:00 +0100
X-MC-Unique: WwJFuWklNRioR6AeYR7C1A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 22:46:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 22:46:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nikolay Borisov' <nik.borisov@suse.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "jslaby@suse.cz" <jslaby@suse.cz>
Subject: RE: [PATCH v2 0/4] Make IA32_EMULATION boot time overridable
Thread-Topic: [PATCH v2 0/4] Make IA32_EMULATION boot time overridable
Thread-Index: AQHZmsNlxcUUAdbQu0asg62sJKhJ1K+Ek7Zg
Date:   Sat, 10 Jun 2023 21:46:55 +0000
Message-ID: <930ebd9ac94843129781ec208a0dd69f@AcuMS.aculab.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
In-Reply-To: <20230609111311.4110901-1-nik.borisov@suse.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov
> Sent: 09 June 2023 12:13
> 
> Here's the 2nd version of the patch which aims to make IA32_EMULATION essentially
> a boot time option. The changes in this posting are:

Does it make any sense to be able to enable/disable it at run-time
(through a sysctl).
Perhaps only if enabled at boot - where it can be a 'soft disable'
even though the cpu is initialised to allow the 32bit system calls.

Remember, if you are root (and the system isn't hard locked down)
it is pretty easy to change a global boolean variable.
So it doesn't really affect the attack surface.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

