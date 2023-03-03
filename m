Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEB26A96EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCCMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCCMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:02:14 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316918B01
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:02:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q23so1303811pgt.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 04:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X66fscKJmjA8mtMvMZBgswWgzjVbJS2oq2kTMl/jyrw=;
        b=Q8p88pwshQfd8SnDRC1u9GbvYaEzWh94FaUAAjl0q0T5KViHdOCRnBl0R+4OS26UIk
         0CmlW2GNRNmKzzTvIRda5kadGQP0iecATzSPrq/lo9jbDHHMbBMNFr4kS9gai+HpYbuL
         xJxJIG3+6ntzx2sanBJQK0pfxaVq5fvqOwADPSAi+bDcy9Cho+jyEnXzZHJSKumESsLs
         hNWaOHZw7EsQ1QSGeu6Q04ojGbi3/Rf94y5pQ3pdcOzmsEi5uTCiH03+1xDVbEzqNUhL
         SSIYG0hKJiFfqWFt2jdcuZ0YlLgVIwT6i0XCcL0x9z+8CskKo1qnL6dnh4l5OwMp2iAY
         c4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X66fscKJmjA8mtMvMZBgswWgzjVbJS2oq2kTMl/jyrw=;
        b=ljTCzHIGk+5YenZXgH8JgMTK+N9Pbs0B8rwCKGuLKNFHQF+olo5urfHhKLTcQj6PEI
         bEIuQqMXAIhbD6sZT/OfcrwWRej57pQA5KxBwIjczQMtg0BSVvCrCsY0Kiht70UhbY80
         Ot0S9cgw4Mco7Q7y2N5/LcIMqGP93uU/nso7EaGeaxv5s+Xj4LFEBdI6nyAmsjathBEa
         FgAJqV0lw6n4mEjFEHWM/lN0Hs16hib/MFBgZZ7cRdR8QcaNiWYoZ6XbFghxfferFONa
         VvMS9oqaiNxvqAFosZXOV3hChUupkjXrkxRwAETXaQZIzU7kTzv04RxOOuUR0D4buj6L
         HqPw==
X-Gm-Message-State: AO0yUKUVhIHtKkARH54+mQHmjpSuiMMMHfPC8GegRrlfUh5I7E8xCQHK
        JBnU/E7+gajn7iC1Q1f0JD6NcI4mVrxSgkdWS0XrZfmRSmTjqA==
X-Google-Smtp-Source: AK7set+oT6iJw6u0lMa2VdxMS/bg+sSQ12Glxj2jNmvp3c0P8hmT4fvcWrkGP5aL+kyOn7FjlRxw4UzW/amJ6S8AVCU=
X-Received: by 2002:a63:291b:0:b0:502:e6c0:88a4 with SMTP id
 bt27-20020a63291b000000b00502e6c088a4mr431481pgb.5.1677844932328; Fri, 03 Mar
 2023 04:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <5712c69ae37447c5b576d87b247f5756@hyperstone.com> <a35f3d45cab0442b9491c0b120e3fb47@hyperstone.com>
In-Reply-To: <a35f3d45cab0442b9491c0b120e3fb47@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Mar 2023 13:01:36 +0100
Message-ID: <CAPDyKFpv3hHvg5X8WNpQEnnsNdGCBMybT-32EGPNYtBtSgK9Fw@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 at 12:40, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
>
> >>
> >> REQ_FUA is in general supported for eMMC cards, which translates into =
so called "reliable writes". To support these write operations, the CMD23 (=
MMC_CAP_CMD23), needs to be supported by the mmc host too, which is common =
but not always the case.
> >>
> >> For some eMMC devices, it has been reported that reliable writes are q=
uite costly, leading to performance degradations.
> >>
> >> In a way to improve the situation, let's avoid announcing REQ_FUA supp=
ort if the eMMC supports an internal cache, as that allows us to rely solel=
y on flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheaper=
.
> >> Note that, those mmc hosts that lacks CMD23 support are already using =
this type of configuration, whatever that could mean.
> >
> > Just note that reliable write is strictly weaker than turning cache off=
/flushing, if card loses power during cache off/flush programming / busy, s=
ector-wise atomicity is not mandated by the spec.
> > (And that is assuming cache off/flush is actually respected by the card=
 as intended by the spec, should some cards be checked?) Maybe some FS peop=
le can also chime in?
>
> Nevermind, the sector-wise atomicity should not matter on 5.1 cards or if=
 the block length isn't being played with, which it isn't in our case.
> If reliable write is implemented only according to spec, I don't see why =
the cache flushing should be less expensive, which would only make sense if
> a) < sector chunks are committed to flash
> b) reliable write is implemented much stricter than the spec, ensuring at=
omicity for the entire write.

Right, I agree!

Note 1) Reliable write was introduced way before cache management in
the eMMC spec. So, if the support for reliable write would have a
stricter implementation than needed, I would not be surprised.

Note 2) In the eMMC v5.1 spec, the cache flushing support has been
extended to allow an explicit barrier operation. Perhaps, we should
let that option take precedence over a regular flush+barrier, for
REQ_OP_FLUSH!?

>
> I guess the cards which increase performance do b)? Or something else?

That's the tricky part to know, as it's the internals of the eMMC.

Although, it seems like both Avri (WDC) and Bean (Micron) would be
happy to proceed with $subject patch, which makes me more comfortable
to move forward.

> Anyway regarding FUA i don't have any concerns regarding reliability with=
 cache flush.
> I can add some performance comparisons with some eMMCs I have around thou=
gh.

That would be great, thanks a lot for helping out with testing!

Kind regards
Uffe
