Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723166143D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 10:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjAHJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 04:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 04:10:28 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A50DF9E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 01:10:27 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a01:e0a:a6a:5f90:5959:63b1:9783:3e26])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 959D313F838;
        Sun,  8 Jan 2023 10:09:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1673169025;
        bh=NmaAlFlb+Pj+1xRu2ZWQZxN5Tp4D5hg7k59Xcd0406Q=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=QhrX3ICiqDzJkLYpH4ykT7+Hd+PImCj6UPqM0b0mQgIl75j7z0h6gQtYLGk8QKr30
         RGLV6ht+b5WPAj0LB/t0KJT12Z61abQ3Z/q8/i3kOtqYvJNRWF++BjogYoiLvHyHIc
         foAebWQISOyfHsmY/yEU7nhDhl3SVYTJ6kPRz2OiIntCjovcj3WXphixHaGrdGSJaV
         2WnoNtVB3e1U7CGgQbNCrt8LTW/kvOj84Rr9PLYXs01jytsGWs8Cs3xZNSCVi/C7y0
         QgKlcVRQJSsvIvNf4CbBVgBmAyoiA9ihGzFAIyJ2vyoSgQqk18gcLmmdKiCA1n8xIm
         97Apljy7gEn/g==
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
 <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com>
 <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
 <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com>
 <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ales Bardorfer <ales@i-tech.si>,
        Ales Snuparek <snuparek@atlas.cz>,
        Alex Osborne <ato@meshy.org>,
        Alex Osborne <bobofdoom@gmail.com>,
        Dirk Opfer <dirk@opfer-online.de>, Ian Molton <spyro@f2s.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Petchkovsky <mkpetch@internode.on.net>,
        Nick Bane <nick@cecomputing.co.uk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Tomas Cech <sleep_walker@suse.cz>,
        Linus Walleij <linusw@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 01/27] ARM: pxa: remove unused board files
Date:   Sun, 08 Jan 2023 10:06:39 +0100
In-reply-to: <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
Message-ID: <m2o7r9gzoc.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Is there any conversion to DT you can easily point at as an 
>> > example of
>> > the kinds of changes needed?
Hi Richard,

There is:
https://lkml.kernel.org/lkml/20180830195941.6118-1-robert.jarzmik@free.fr/t/

This is a rather complete example of a pxa27x board working in DT 
:
(audio, camera, cpufreq, sd, screen, uarts, udc, keypad).

Cheers.

--
Robert
