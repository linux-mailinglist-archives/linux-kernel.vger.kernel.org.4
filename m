Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24E667B80C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjAYRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbjAYRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:09:38 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A55A82D;
        Wed, 25 Jan 2023 09:09:20 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p12so9005656ilq.10;
        Wed, 25 Jan 2023 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5P3w0w+WXNZLyK8vs6Uzl0Ve75G9GOWC07KFJ/51V8=;
        b=FWMjdM+nhHB/EB3sxzOOdwNmYFj17CUION1bNz2V7YxHdBF2+4k78yWG67nfg6Va06
         C8aBMHaV9M2Y+Mo2g9PypMMRfgbNtVT6S6EbqpN/TZqG2fEB4GdEz2pl6QIFdQS2J/1M
         4tgxxJb7PB64/uWf4qMrgqB9hkvruwYQT7wS7zOmvAa//5XXyyodOAW828gS+vT7F5KO
         AVvHUv6fUi0hf7hCiEcDEITLooHL1eOd1q8puTmZlos4KTruYarEYsUhm3UPCMnKuRw8
         Uj2khL5O90MUNBpW+ovCJxpqHvIpz7Bv/ZovRMMxs3MN7U1LyPEwWZKUdIr0QoqyVwtf
         x6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5P3w0w+WXNZLyK8vs6Uzl0Ve75G9GOWC07KFJ/51V8=;
        b=45rYbRSPGA2U9wbZYXEg81W+dy2YFsc/ma3F5ftWeIm3vLut1QHIloQHg7/zVZqeEe
         IMck2L4leP8iYtTSXNaoigM3jIt4e9w9gN+ExilX0qR+EbTQZgyAdg95Q7stzYFm55UC
         sU40Fqj+Y4ZMCqQNUForLX4PQza7AKRqw5acCvHx0O0lYyI7j5SDcYr1G0EBkolULbJz
         dTBMOLxN9uD2yniHwlxfqjxV/UwYlZ8l56RKo8WmqetmXdmlVr3+XJrxv21pSYa/E/Em
         ci0oQMMbSqMOWyJVbmx8RLwvAfW7v87s05HD4TLPfxVgfn1YcUjBtwkTxYdkxeY0qKfd
         /Q+A==
X-Gm-Message-State: AFqh2kpLrzKxgcVYu4UlsFUtvkzKtKvVOXIND3lhk0tHopJh9frZfIVM
        uO35lLXCD0/G5zgqOh93QwIWSSk3lOtUGroFfqTXBYOL
X-Google-Smtp-Source: AMrXdXuZXwKplOi36CKmJgn91hbnSFElWD+XbceO+gYEaBg/bTxjdfrRsNvQ09TQdQvbo6RnHYWoyeew5AvNm9FQPmw=
X-Received: by 2002:a05:6e02:c0d:b0:30f:5797:2c71 with SMTP id
 d13-20020a056e020c0d00b0030f57972c71mr2043663ile.51.1674666558297; Wed, 25
 Jan 2023 09:09:18 -0800 (PST)
MIME-Version: 1.0
References: <Y86cy1AM4w5ju5A4@kroah.com> <Y9Ff3Np86AUK4b1k@jo-einhundert> <Y9Fhk2A6/1XJgJ/0@kroah.com>
In-Reply-To: <Y9Fhk2A6/1XJgJ/0@kroah.com>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Wed, 25 Jan 2023 18:09:07 +0100
Message-ID: <CAMUOyH3J71UWBDTZm1eUXkRgnb3_ejYXi6R0LU+iSkiZ6fU5Ag@mail.gmail.com>
Subject: Re: [PATCH v5] usb: gadget: add WebUSB landing page support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for letting me know. I'm not that sure on the exact process
yet, so thanks a lot for bearing with me.

I'll send a new patch in a few moments.

Thanks,
J=C3=B3

On Wed, Jan 25, 2023 at 6:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 25, 2023 at 05:59:08PM +0100, J=C3=B3 =C3=81gila Bitsch wrote=
:
> > There is a custom (non-USB IF) extension to the USB standard:
> >
> > https://wicg.github.io/webusb/
> >
> > This specification is published under the W3C Community Contributor
> > Agreement, which in particular allows to implement the specification
> > without any royalties.
>
> <snip>
>
> No, I can't revert the existing patch and then add this one, just send a
> set of follow-on patches that fix up the needed things and I can apply
> that as I can not rebase my public tree.
>
> thanks,
>
> greg k-h
