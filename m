Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC07869C210
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 19:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjBSS5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 13:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBSS5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 13:57:42 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC829C66A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 10:57:41 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id l12so492908vsm.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676833061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWNimodxi9au0r5Bzipoe0I7y/50LsaRmfxwonhr5yw=;
        b=NItqE9cDn+7xnRSLaeOmVP8n/yaKr2xhsDJffFt9GYe1ZyAas06GVB590Ez+JavOi9
         UpDaT9J87GXZ2sACBSYTkVwv26pci2+/WtjUibMqLO5px0j1rc4BPOa6feLPYtHu2o9W
         p1OPomMkN5mnETA1lI2RyikAdPoece/3onm3YQM1jSM5mC3T7nZOJ28R22+ZbV6HNFKm
         KlMTVoOhCG2xqjUl6PTslJMhs28su9ef3Y54wvXETtxYaulBkNPJ3XEM/FRINlZEWMJy
         OXdTG3qFN1zb03j5odieu+MKCnQh8Pft34b9+VYsto4Wv8JfbgkS6EUAaR29U4Rf3cDQ
         FqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676833061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWNimodxi9au0r5Bzipoe0I7y/50LsaRmfxwonhr5yw=;
        b=jdatLyW3iWnXN2544XxZUzaT3q9Xby3NJ+z4BbqreTzXXOpuewmaPHIzLf2NubTpHQ
         crUWCnTbbv14OBfoS1MbLoCkSF/0Lv33Q5UIRrP9O/qtRUJvfGAsuiLSk5CH3eNIx8gy
         cJLYVaQ/UJ9GkBj0OSaYYpeRxS90o9rSBJC7CCI13El5RyWD1ejYruC6ABuFtcgsGENy
         FYNLzEFjLZV5wOXGO+jfVjPsr9W2/6FaGDKd5hC1BAnML4w2bBpcdGVV0kiKJgwpE8km
         2oZ6jIfKOeBau1I2w/xP+E/xTRA0ng08qQFOSb0sR0Yhf7vWBk+l3O5HbtzZY9z1FO4j
         jM9w==
X-Gm-Message-State: AO0yUKUenRfK6J6sHDgxDB51hkinduf8MPzymllDnV7/wc3m4oHcmhbm
        3Xajk5i6Ma/5JP9O9cs6H6xxTzm3hhrrnzjRUGRpNg==
X-Google-Smtp-Source: AK7set/L7c6RqYyk5BpEa7w37MSB+QunqeHeN1u2QszV6pCx6bhn0OYsBQVuDpwhMJuiEVNm3JoaBzn6OgfxxMDYcWY=
X-Received: by 2002:a05:6102:23d7:b0:411:a761:635f with SMTP id
 x23-20020a05610223d700b00411a761635fmr119350vsr.8.1676833060729; Sun, 19 Feb
 2023 10:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20230113193006.1320379-1-bgeffon@google.com> <20230114001518.1378049-1-bgeffon@google.com>
 <CAJZ5v0geG==MmZfvFBZgkuOuWE17BXYSMEzcYmyz6CALp6w2Fw@mail.gmail.com>
 <CADyq12wAkX+hAzuFgHj7k_Woy=G+3PLwpTc+UUxjp4bPe46_cw@mail.gmail.com> <Y/C7EO5xUHh4p/MS@duo.ucw.cz>
In-Reply-To: <Y/C7EO5xUHh4p/MS@duo.ucw.cz>
From:   Brian Geffon <bgeffon@google.com>
Date:   Sun, 19 Feb 2023 13:56:57 -0500
Message-ID: <CADyq12wYWF_SrcY3Zbt3cTq46yWdKwTJHbDAECU71r5A-=aNew@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: don't store zero pages in the image file.
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 6:49 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!

Hey Pavel,

>
> > > I need some more time to go through this in more detail, so it is
> > > likely to miss 6.3.  Sorry about that.
> >
> > No problem, consider this more of an RFC, it seems like a
> > low-risk/low-cost way to reduce image sizes so I was just hoping to
> > get feedback. Take your time reviewing.
>
> Seems like special case of compression, really, it might be better to
> leave it to compression algorithm to solve that.

It's true that it seems like an optimization that really does resemble
compression. But there are a few distinctions I'd like to call out;
firstly, this optimization has effectively an infinite compression
ratio as the zero pages never have to be included at all for that
reason this benefits both the compressed and non-compressed use-cases.
Additionally, this is basically free for both the swsusp and uswsusp
paths as it's transparently handled in the
snapshot_read_next/snapshot_write_next paths.

>
> Not sure if lzo is optimal if you want max speed, but things like gzip
> should be "almost free", too.

While certain compression algorithms are cheap they are definitely not
free. This specific optimization ultimately results in a single OR
after testing the zero flag from a word copy we were already
performing, now that's pretty much free :)

Another final thing I'd like to note about this is that when
compressing today, the default is to compress in 32 page chunks
(iirc). By including the zero pages in those 32 pages you're limiting
your ability to better compress the "real" data, if that makes sense.
Why bother copying those zero pages over to the compressor kthreads
anyway? With all that being said, the code itself is certainly not
free in the sense that it does add some complexity to both the read
and write paths, do you guys think that additional complexity is worth
the benefits we might see?

>
> Best regards,
>                                                                 Pavel

Thanks for taking the time to discuss this!


Brian

> --
> People of Russia, stop Putin before his war on Ukraine escalates.
