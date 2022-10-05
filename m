Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590EC5F505D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJEHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJEHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:33:52 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB174E3F;
        Wed,  5 Oct 2022 00:33:51 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id k9so8156517vke.4;
        Wed, 05 Oct 2022 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=KVC1lmZuvftP+vZSwxWEmcUh79spffs/zfdc0wm2KEk=;
        b=pMamGeCdA7yyvMRzVWcIZQiTeHRRAcz/4cG21g73x/FSoSyGKenkbvV2e75FxPHzke
         OLT5yaNHmbS10Q9CxUNdBeqVq/6xV4kaHeZpqHkBtj2xZw5xPs7cFjAzwJNbmNl1tLCb
         Fwi67jDTEVh7dm8p3yigDpO+VD679uH9H1z1hfBZbd1xnxJrItpMgF8ebyojE+jAkpR0
         FJeKfsCtD/WMrjCefsAAYTuGtQN0I9zxvw9tUkUSMZ+SQ+4SqOcg6KOt9mVkVsLbzWIB
         FWAWAzALNcuySfrKa6TzG7xhIdYj4+ZOz75oF43IplQpqNDPz3OqS1X4A1t6tGY6kTM6
         Fyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KVC1lmZuvftP+vZSwxWEmcUh79spffs/zfdc0wm2KEk=;
        b=yluV5ej7XGBy0sL7tiEd28HdzsXZQNQb4DnmkOJII/FFGmM1o1GdDUjznTd17TWdZq
         AEgbOqRCJRswuOATlOdp/SPXvoRRtJgbC+Z4tPhSeZTBWO+77M3yi0udm3r5qUgH0cMB
         G96oyVptK9jBGCVg3XUCcwPvUBFkEYPiw1aE9baVqcWPQDEyKduHsXI0Qlm5NA2C0tqX
         BcIH0mkERZH9Pi9U7MSVmCqvcAiuvffBzbYwFiuSR/dnM1L1TBWTc7Pi3WD8NQF9mBsK
         m1DWeIigUsaLXbfUffc3CPmcRTEb6LFUVVRFnS37zaS4oRa5kV5DMqPiEZoQ9PdoJZTm
         3XPQ==
X-Gm-Message-State: ACrzQf3rvYzVoMDsbp2VtQnCMQ5R8d8OjdnNiuM9Tzjk3ykPKj12mMVl
        9g3YTHMhe9vVEgPzEFezeG7O8nWm1hA8EGWqqUQ=
X-Google-Smtp-Source: AMsMyM5rcy52NtNh3GmvQ5Sp8hiiiQp7qJ1bkIVh2Xrtn9yQa8eycg/TyUv7Qro9C0KSeaGUTMilWk1VZHhfV1zHCOQ=
X-Received: by 2002:a1f:d042:0:b0:3a2:4c49:411e with SMTP id
 h63-20020a1fd042000000b003a24c49411emr13720327vkg.10.1664955230750; Wed, 05
 Oct 2022 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220603190509.45986-1-romain.perier@gmail.com>
 <20220603190509.45986-2-romain.perier@gmail.com> <20220930191742.9A9FEC433C1@smtp.kernel.org>
 <20220930193535.GB9469@1wt.eu>
In-Reply-To: <20220930193535.GB9469@1wt.eu>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Wed, 5 Oct 2022 09:33:40 +0200
Message-ID: <CABgxDoK-r_ENKo4qcB3PbCS2KOifHhzMvy1gWM=8yEsrH4JVvQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/1] clk: mstar: msc313 cpupll clk driver
To:     Willy Tarreau <w@1wt.eu>
Cc:     Stephen Boyd <sboyd@kernel.org>, Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi,

Quiet frankly I don't want to debate about this , as is it seems to be
basically "the rule" (see
https://www.kernel.org/doc/html/v6.0/process/submitting-patches.html).
It is okay for you Willy, if I transform your tag to
"Co-developed-by:" plus a "Signed-off-by" ? So Stephen can apply it ,
and everyone is happy :)

Cheers,
Romain

Le ven. 30 sept. 2022 =C3=A0 21:35, Willy Tarreau <w@1wt.eu> a =C3=A9crit :
>
> Hi Stephen,
>
> On Fri, Sep 30, 2022 at 12:17:40PM -0700, Stephen Boyd wrote:
> > Quoting Romain Perier (2022-06-03 12:05:09)
> > > From: Daniel Palmer <daniel@0x0f.com>
> > >
> > > Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> > > in MStar SoCs.
> > >
> > > Currently there is no documentation for this block so it's possible
> > > this driver isn't entirely correct.
> > >
> > > Only tested on the version of this IP in the MStar/SigmaStar
> > > ARMv7 SoCs.
> > >
> > > Co-authored-by: Willy Tarreau <w@1wt.eu>
> >
> > This is not a standard tag, maybe Co-developed-by is what you want?
>
> Yeah it's the same. We're seeing 122 co-authored-by tags in the
> kernel's history vs 3122 co-developed-by, so that's only 3% but
> at least not a fantasist one..
>
> > A Signed-off-by tag should be here from Willy Tarreau then.
>
> Not all commits follow this, but indeed some do. Regardless I
> really don't care at all about my name being listed there.
>
> > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> >
> > Your Signed-off-by needs to be here. I can't apply this otherwise.
>
> Quite frankly, we're talking about an old patch that was first
> submitted 9 months ago (!), let's not postpone it even further just
> for headers reason, please just drop this line mentioning my
> little contribution, I don't care a single second at all, really.
>
> Thanks,
> Willy
