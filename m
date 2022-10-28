Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B3610F42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJ1LBS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Oct 2022 07:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ1LBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:01:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C5E1B7F32
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:01:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-237-22Dr50z3PuWQWbxBYKSvpw-1; Fri, 28 Oct 2022 12:01:10 +0100
X-MC-Unique: 22Dr50z3PuWQWbxBYKSvpw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 28 Oct
 2022 12:01:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Fri, 28 Oct 2022 12:01:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Joao Moreira" <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Mark Rutland" <mark.rutland@arm.com>
Subject: RE: [PATCH 0/4] x86/ibt: Implement FineIBT
Thread-Topic: [PATCH 0/4] x86/ibt: Implement FineIBT
Thread-Index: AQHY6eaqrH5B7d5A2kqD+PKSAMrXq64jpC0w
Date:   Fri, 28 Oct 2022 11:01:08 +0000
Message-ID: <322c0b333f0a4a60be2a89f0cdf7edde@AcuMS.aculab.com>
References: <20221027092812.185993858@infradead.org>
In-Reply-To: <20221027092812.185993858@infradead.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 27 October 2022 10:28
> 
> Hi all,
> 
> Updated FineIBT series; I've (hopefully) incorporated all feedback from last
> time with the notable exception of the Kconfig CFI default -- I'm not sure we
> want to add to the Kconfig space for this, also what would a distro do with it.
> 
> Anyway; please have a look, I'm hoping to merge this soonish so we can make the
> next cycle.

Is there a test to ensure that modules are actually compiled
with the required endbra, function prologue gap (etc).
Having the module load fail is somewhat better than a crash.

It is almost certainly quite easy to generate an out of tree module that
is missing all of those (even if compiled at the same time as the kernel).
(Never mind issues with modules that contain binary blobs.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

