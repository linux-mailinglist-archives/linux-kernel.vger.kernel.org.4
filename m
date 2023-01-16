Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7BC66CF25
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjAPSwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjAPSwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:52:16 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319344ED2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:52:15 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id o66so24095668oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LktYHImIYTKrg1V9Z5iwsufx2tDCyUF+m2ST+OXu5pc=;
        b=pN4f3QxmGMYspl5gxGo5cV/51F97qQCRXVbLBQQFmprBawa/Tl26jlvNs78XWX3zmA
         17itgBKFOXl7TzdTaWjSyTdzrKTLobWe6J9yR0nn9y9Mbrz7/B0Tyxpd1JFYaTMaIcXb
         TNtmXCOr+YCwiGGKtC8efhtssL/d+cuAIwm99DdjwsNGtVbZLrlcR01Tpz4vOWnDoBUc
         tPrF63m/j8+gqzNLXhvxnoq/82nUaF7cv34tNfTBsh94pS+6AdKDT/dpE+RU87xLcd3L
         zjBzoUNq6ZUXXd4+9ZXU9r/TbyGF7KFrDochTAvsoAfeBaRn2PTnGGdE7UKP9JLLfrHL
         74kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LktYHImIYTKrg1V9Z5iwsufx2tDCyUF+m2ST+OXu5pc=;
        b=m25lj7j0gD2QI5iSJrOVh26LNwmJNvVVf5efNfUdCzWA6S2HOVHqG8/TLnk/DTAGwh
         4MWZufO6FKXEjHShshw1FjEBgAtnTb2NqauPP2FvpYWLZqXZF0Ke1LM22LbOZsifNJ74
         AIjEigx1+0vq7RSOGu58DqfKIJGyy0LU3jhe3xL+VBwMv9NGnZ8yg35vT5cOOVNuQt8L
         /9pEOox1R+S8J4XcgDpwJAKaY797cPfDL8ycHpZ3MypTZyUeSSeoZkHhyNDlcFnP6+kB
         NR47F3nDk3LnpoxBDPF8HB53luBdyYGLVugPY7PgWdxuziQ/4r6YCsz97hys5veApZGA
         lygA==
X-Gm-Message-State: AFqh2krs4amDbSUE1EJgcdKsBpNUJDKUle6XAQw1aSzFyPbhoV7OZ6u2
        O4DAZv5qsivcKzdJfPl2qQSzcOHfc4E=
X-Google-Smtp-Source: AMrXdXtJtMSTtNDddBj1IICeizUDjfhetAioSAnyjDqQCZRD+96c3F/sFDJyDjodswD6dXw3ZfNitw==
X-Received: by 2002:a05:6808:1649:b0:35e:2b82:2591 with SMTP id az9-20020a056808164900b0035e2b822591mr10424787oib.10.1673895134485;
        Mon, 16 Jan 2023 10:52:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bl17-20020a056808309100b00359ba124b07sm13340243oib.36.2023.01.16.10.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:52:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 16 Jan 2023 10:52:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc4
Message-ID: <20230116185212.GA2127972@roeck-us.net>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 09:29:46AM -0600, Linus Torvalds wrote:
> It's Sunday afternoon in some parts of the world, and since I'm going
> to spend the rest of the day on airports and flights, that's good
> enough for me.
> 
> So here's another -rc release, this time with pretty much everybody
> back from winter holidays, and so things should be back to normal. And
> you can see that in the size, this is pretty much bang in the middle
> of a regular rc size for this time in the merge window.
> 
> The stats look fairly normal too, perhaps with a slight emphasis on
> networking that was playing catch-up after the holidays. But there's
> various changes all over - scan the appended shortlog for a taste of
> what has been going on.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 502 pass: 502 fail: 0

... and no runtime warnings.

Guenter
