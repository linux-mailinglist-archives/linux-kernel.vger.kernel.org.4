Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8897D63B407
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiK1VMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiK1VMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:12:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C5B5FC2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:12:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA506B8101D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2318EC433D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:12:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hWbveoYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669669936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tdv3VZ/aswB5hl1uH0uYiexGqoeWOaJJUoj8aDz03r4=;
        b=hWbveoYUKpUHeLE2siUXAW3tCaHMXmvWlvMszGCGRfdvBvFcoMZEl9WDo18ZVzqgbkUbfj
        S8a6iDbj/RaRG2LNwDIbZwuyGgQagaqQB4vuPRApH52wqWWUcgR8uuxiipfnUnE9z+1gBW
        RbJxK/rRePvayh8A9Yaf9uYHax8uCsA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 49f8298d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 28 Nov 2022 21:12:16 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id i11so10936554vsr.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:12:16 -0800 (PST)
X-Gm-Message-State: ANoB5pkWLWXS/rKQgXrR9QWxMfPMlXLXbYW6D/eXwAud/f88pUff2nzH
        dt4Xk0p28JFpP12r3WeVxMqvVASSFafMq1Lc+Vg=
X-Google-Smtp-Source: AA0mqf4fYAUIR9nYbf9cZa/TwNKxtYD60y6yqUiNo+kBgcgsYuAPR97BMPXzp8TmrUNtKvkMjZ2qsnL3FdWvqCmwomU=
X-Received: by 2002:a67:1d41:0:b0:3aa:3310:174 with SMTP id
 d62-20020a671d41000000b003aa33100174mr20125207vsd.70.1669669935573; Mon, 28
 Nov 2022 13:12:15 -0800 (PST)
MIME-Version: 1.0
References: <202211290400.IuVDsFIm-lkp@intel.com> <CAHmME9oO=8hsc4zt_oBrRoGm3sMU03W7cP5PksfC-RFmZumGLQ@mail.gmail.com>
 <6358eb8f-a3ef-40ef-9d3a-842d9ff34709@app.fastmail.com>
In-Reply-To: <6358eb8f-a3ef-40ef-9d3a-842d9ff34709@app.fastmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Nov 2022 22:12:04 +0100
X-Gmail-Original-Message-ID: <CAHmME9phWJFQvawqC7pN-2QNMeNTmakjQqi2e35EOH9=E=dsmg@mail.gmail.com>
Message-ID: <CAHmME9phWJFQvawqC7pN-2QNMeNTmakjQqi2e35EOH9=E=dsmg@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:crng/random/vdso 20/22] include/uapi/asm-generic/unistd.h:890:34:
 error: 'sys_vgetrandom_alloc' undeclared here (not in a function); did you
 mean 'sys_getrandom'?
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Nov 28, 2022 at 10:11 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 28, 2022, at 22:03, Jason A. Donenfeld wrote:
> > Hi Arnd,
> >
> > Please see below. It would seem that I can't so easily get rid of that
> > #ifdef __ARCH_HAS afterall?
> ...
> >>          | ^~~~~~~~~
> >> >> include/uapi/asm-generic/unistd.h:890:34: error: 'sys_vgetrandom_alloc' undeclared here (not in a function); did you mean 'sys_getrandom'?
>
> No, this just means that some architectures require you to have the correct
> prototype for the system call in include/linux/syscalls.h, without an #ifdef.

Oh okay, thanks! I'll look into that.

Jason
